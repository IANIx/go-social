package service

import (
	"context"
	"errors"
	"math"

	"go-social/internal/model"
	"go-social/internal/model/entity"
	"go-social/internal/service/internal/dao"
	"go-social/internal/service/internal/do"

	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/os/gtime"
	"github.com/gogf/gf/v2/util/gconv"
	// "github.com/gogf/gf/v2/crypto/gmd5"
	// "github.com/gogf/gf/v2/database/gdb"
	// "github.com/gogf/gf/v2/errors/gerror"
	// "github.com/gogf/gf/v2/os/gtime"
)

type (
	sFeed struct{}
)

var (
	insFeed = sFeed{}
)

func Feed() *sFeed {
	return &insFeed
}

/// 发布文章
func (s *sFeed) PostArticle(ctx context.Context, in model.FeedPostActicleInput) (ou model.FeedCommonOutput, err error) {
	err = dao.Article.Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {

		_, err = dao.Article.Ctx(ctx).Data(do.Article{
			Uid:        gconv.Int(Auth().GetIdentity(ctx)),
			Title:      in.Title,
			Content:    in.Content,
			Img:        in.ImageUrl,
			State:      1,
			CreateTime: gtime.Now().TimestampMilli(),
			UpdateTime: gtime.Now().TimestampMilli(),
		}).Insert()
		return err
	})

	ou.Success = err == nil

	return
}

// 获取文章列表
func (s *sFeed) ArticleList(ctx context.Context, in model.FeedActicleListInput) (ou model.FeedActicleListOutput, err error) {

	var acticles []*model.FeedArticle
	baseModel := dao.Article.Ctx(ctx).As("a").LeftJoin(dao.User.Table(), "u.id = a.uid").As("u").
		WherePrefix("a", do.Article{
			State: 1,
		})

	total, err := baseModel.Count()
	if err != nil {
		return
	}

	err = baseModel.
		Fields(
			"a."+dao.Article.Columns().Id,
			"a."+dao.Article.Columns().Title,
			"a."+dao.Article.Columns().Content,
			"a."+dao.Article.Columns().Img,
			"a."+dao.Article.Columns().CommentNum,
			"a."+dao.Article.Columns().PraiseNum,
			"a."+dao.Article.Columns().Uid,
			"a."+dao.Article.Columns().CreateTime,
			"u."+dao.User.Columns().NickName,
			"u."+dao.User.Columns().Avatar,
		).
		OrderDesc("create_time").
		Page(in.PageNum, in.PageSize).
		Scan(&acticles)

	ou.Total = total
	ou.Pages = int(math.Ceil(float64(total) / float64(in.PageSize)))
	ou.Data = acticles

	return ou, err
}

// 获取文章详情
func (s *sFeed) ArticleDetail(ctx context.Context, in model.FeedActicleInput) (ou model.FeedActicleDetailOutput, err error) {

	article, err := s.QueryArticle(ctx, in.AID)
	if err != nil {
		return ou, err
	}

	/// 查询点赞信息(包含文章点赞&评论点赞)
	var likes []*model.ArticleLike
	baseLikeModel := dao.Praise.Ctx(ctx).As("p").LeftJoin(dao.User.Table(), "u.id = p.uid").As("u")
	err = baseLikeModel.
		Fields(
			"p."+dao.Praise.Columns().Type,
			"p."+dao.Praise.Columns().TypeId,
			"p."+dao.Praise.Columns().Uid,
			"p."+dao.Praise.Columns().CreateTime,
			"u."+dao.User.Columns().NickName,
			"u."+dao.User.Columns().Avatar,
		).
		WherePrefix("p", (do.Praise{
			State: 1,
			Aid:   article.Id,
		})).
		OrderDesc("p.update_time").
		Scan(&likes)

	if err != nil {
		return ou, err
	}

	/// 查询评论信息
	var comments []*model.ArticleComment
	baseCommentModel := dao.Comment.Ctx(ctx).As("c").LeftJoin(dao.User.Table(), "u.id = c.uid").As("u")
	err = baseCommentModel.
		Fields(
			"c."+dao.Comment.Columns().Id,
			"c."+dao.Comment.Columns().Aid,
			"c."+dao.Comment.Columns().Uid,
			"c."+dao.Comment.Columns().CommentCont,
			"c."+dao.Comment.Columns().CreateTime,
			"c."+dao.Comment.Columns().PraiseNum,
			"u."+dao.User.Columns().NickName,
			"u."+dao.User.Columns().Avatar,
		).
		WherePrefix("c", (do.Comment{
			State: 1,
			Aid:   article.Id,
		})).
		OrderDesc("c.update_time").
		Scan(&comments)

	var article_likes []*model.ArticleLike = make([]*model.ArticleLike, 0)
	var comment_likes map[int]*model.ArticleComment = make(map[int]*model.ArticleComment)

	for _, item := range comments {
		comment_likes[item.Id] = item
	}

	for _, item := range likes {
		if item.Type == 1 {
			// 文章点赞
			article_likes = append(article_likes, item)
			if item.Uid == gconv.Int(Auth().GetIdentity(ctx)) {
				ou.IsLike = true
			}
		} else if item.Type == 2 {
			// 评论点赞
			comment_id := item.TypeId

			var comment = comment_likes[comment_id]

			if item.Uid == gconv.Int(Auth().GetIdentity(ctx)) {
				comment.IsLike = true
			}
		}
	}

	ou.Likes = article_likes
	ou.Comments = comments

	return
}

/// 创建文章评论
func (s *sFeed) ArticleComment(ctx context.Context, in model.FeedActicleCommentInput) (ou model.FeedCommonOutput, err error) {
	article, err := s.QueryArticle(ctx, in.AID)
	if err != nil {
		return ou, err
	}

	err = dao.Comment.Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {

		_, err = dao.Comment.Ctx(ctx).Data(do.Comment{
			CommentCont: in.Comment,
			Aid:         in.AID,
			ToUid:       article.Uid,
			Uid:         gconv.Int(Auth().GetIdentity(ctx)),
			CreateTime:  gtime.Now().TimestampMilli(),
			UpdateTime:  gtime.Now().TimestampMilli(),
		}).Insert()
		return err
	})

	if err == nil {
		ou.Success = true
		_, err = dao.Article.Ctx(ctx).Where(do.Article{
			Id: in.AID,
		}).Increment(dao.Article.Columns().CommentNum, 1)
		if err != nil {
			return ou, err
		}
	}

	return
}

/// 文章/评论 - 点赞/取消点赞
func (s *sFeed) GiveLike(ctx context.Context, in model.FeedActicleGiveLikeInput) (ou model.FeedCommonOutput, err error) {

	if in.Type != 1 && in.Type != 2 {
		err = errors.New("类型错误")
		return
	}

	if in.Type == 1 { //文章
		article, err := s.QueryArticle(ctx, in.TypeId)
		if err != nil {
			return ou, err
		}

		result, err := HandlePraise(ctx, model.FeedGiveLikeInput{
			Type:   in.Type,
			TypeId: in.TypeId,
			AID:    article.Id,
			ToUid:  article.Uid,
		})

		/// 更新文章点赞数
		if err == nil {
			if result == 2 {
				_, err = dao.Article.Ctx(ctx).Where(do.Article{
					Id: article.Id,
				}).Decrement(dao.Article.Columns().PraiseNum, 1)
			} else {
				_, err = dao.Article.Ctx(ctx).Where(do.Article{
					Id: article.Id,
				}).Increment(dao.Article.Columns().PraiseNum, 1)
			}

			if err != nil {
				return ou, err
			}
		}

	} else if in.Type == 2 { // 评论

		comment, err := QueryComment(ctx, in.TypeId)
		if err != nil {
			return ou, err
		}

		result, err := HandlePraise(ctx, model.FeedGiveLikeInput{
			Type:   in.Type,
			TypeId: in.TypeId,
			AID:    comment.Aid,
			ToUid:  comment.Uid,
		})

		/// 更新评论点赞数
		if err == nil {

			if result == 2 {
				_, err = dao.Comment.Ctx(ctx).Where(do.Comment{
					Id: comment.Id,
				}).Decrement(dao.Comment.Columns().PraiseNum, 1)
			} else {
				_, err = dao.Comment.Ctx(ctx).Where(do.Comment{
					Id: comment.Id,
				}).Increment(dao.Comment.Columns().PraiseNum, 1)
			}

			if err != nil {
				return ou, err
			}
		}
	}

	if err == nil {
		ou.Success = true
	}

	return
}

// 获取我的文章列表
func (s *sFeed) MineArticleList(ctx context.Context, in model.FeedActicleListInput) (ou model.FeedActicleListOutput, err error) {

	var acticles []*model.FeedArticle
	baseModel := dao.Article.Ctx(ctx).As("a").LeftJoin(dao.User.Table(), "u.id = a.uid").As("u").
		WherePrefix("a", do.Article{
			State: 1,
			Uid:   gconv.Int(Auth().GetIdentity(ctx)),
		})

	total, err := baseModel.Count()
	if err != nil {
		return
	}

	err = baseModel.
		Fields(
			"a."+dao.Article.Columns().Id,
			"a."+dao.Article.Columns().Title,
			"a."+dao.Article.Columns().Content,
			"a."+dao.Article.Columns().Img,
			"a."+dao.Article.Columns().CommentNum,
			"a."+dao.Article.Columns().PraiseNum,
			"a."+dao.Article.Columns().Uid,
			"a."+dao.Article.Columns().CreateTime,
			"u."+dao.User.Columns().NickName,
			"u."+dao.User.Columns().Avatar,
		).
		OrderDesc("create_time").
		Page(in.PageNum, in.PageSize).
		Scan(&acticles)

	ou.Total = total
	ou.Pages = int(math.Ceil(float64(total) / float64(in.PageSize)))
	ou.Data = acticles

	return ou, err
}

// 获取我点赞的文章列表
func (s *sFeed) MineLikeArticleList(ctx context.Context, in model.FeedActicleListInput) (ou model.FeedActicleListOutput, err error) {

	var acticles []*model.FeedArticle
	baseModel := dao.Praise.Ctx(ctx).As("p").
		WherePrefix("p", do.Praise{
			State: 1,
			Type:  1,
			Uid:   gconv.Int(Auth().GetIdentity(ctx)),
		}).LeftJoin(dao.Article.Table(), "p.aid = a.id").As("a").
		LeftJoin(dao.User.Table(), "u.id = a.uid").As("u").
		WherePrefix("a", do.Article{
			State: 1,
		})
	total, err := baseModel.Count()
	if err != nil {
		return
	}

	err = baseModel.
		Fields(
			"a."+dao.Article.Columns().Id,
			"a."+dao.Article.Columns().Title,
			"a."+dao.Article.Columns().Content,
			"a."+dao.Article.Columns().Img,
			"a."+dao.Article.Columns().CommentNum,
			"a."+dao.Article.Columns().PraiseNum,
			"a."+dao.Article.Columns().Uid,
			"a."+dao.Article.Columns().CreateTime,
			"u."+dao.User.Columns().NickName,
			"u."+dao.User.Columns().Avatar,
		).
		OrderDesc("create_time").
		Page(in.PageNum, in.PageSize).
		Scan(&acticles)

	ou.Total = total
	ou.Pages = int(math.Ceil(float64(total) / float64(in.PageSize)))
	ou.Data = acticles

	return ou, err
}

// 查询文章
func (s *sFeed) QueryArticle(ctx context.Context, aid int) (article *entity.Article, err error) {
	err = dao.Article.Ctx(ctx).Where(do.Article{
		Id: aid,
	}).Scan(&article)

	if article == nil {
		return article, errors.New("该文章不存在")
	}

	if article.State != 1 {
		return article, errors.New("该文章已删除")
	}
	return
}

// 查询评论
func QueryComment(ctx context.Context, commentId int) (comment *entity.Comment, err error) {
	err = dao.Comment.Ctx(ctx).Where(do.Comment{
		Id: commentId,
	}).Scan(&comment)

	if comment == nil {
		return comment, errors.New("该评论不存在")
	}

	if comment.State != 1 {
		return comment, errors.New("该评论已删除")
	}
	return
}

func HandlePraise(ctx context.Context, in model.FeedGiveLikeInput) (int, error) {
	result := 0 // 1: 点赞数+1，2: 点赞数-1
	praise, err := dao.Praise.Ctx(ctx).Where(do.Praise{
		Type:   in.Type,
		TypeId: in.TypeId,
		Uid:    gconv.Int(Auth().GetIdentity(ctx)),
	}).One()

	if err != nil {
		return result, err
	}

	if praise != nil { // 已有数据，更新操作
		var state = 1
		if gconv.Int(praise["state"]) == 1 {
			state = 9
		}
		_, err = dao.Praise.Ctx(ctx).Data(do.Praise{
			UpdateTime: gtime.Now().TimestampMilli(),
			State:      state,
		}).Where(do.Praise{
			Type:   in.Type,
			TypeId: in.TypeId,
			Uid:    gconv.Int(Auth().GetIdentity(ctx)),
		}).Update()

		if err == nil {
			if state == 1 {
				result = 1
			} else if state == 9 {
				result = 2
			}
		}
	} else { // 创建点赞
		err = dao.Praise.Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {

			_, err = dao.Praise.Ctx(ctx).Data(do.Praise{
				Uid:        gconv.Int(Auth().GetIdentity(ctx)),
				ToUid:      in.ToUid,
				Type:       in.Type,
				TypeId:     in.TypeId,
				Aid:        in.AID,
				CreateTime: gtime.Now().TimestampMilli(),
				UpdateTime: gtime.Now().TimestampMilli(),
			}).Insert()
			return err
		})

		if err == nil {
			result = 1
		}
	}

	return result, err
}
