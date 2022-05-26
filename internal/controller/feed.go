package controller

import (
	"context"

	v1 "go-social/api/v1"
	"go-social/internal/model"
	"go-social/internal/service"
)

var (
	Feed = cFeed{}
)

type cFeed struct{}

// 发布文章
func (c *cFeed) PostArticle(ctx context.Context, req *v1.FeedPostArticleReq) (res *v1.FeedPostArticleRes, err error) {
	output, err := service.Feed().PostArticle(ctx, model.FeedPostActicleInput{
		Title:    req.Title,
		Content:  req.Content,
		ImageUrl: req.ImageUrl,
	})

	res = &v1.FeedPostArticleRes{
		Success: output.Success,
	}

	return
}

// 文章列表
func (c *cFeed) ArticleList(ctx context.Context, req *v1.FeedArticleReq) (res *v1.FeedArticleRes, err error) {
	output, err := service.Feed().ArticleList(ctx, model.FeedActicleListInput{
		PageNum:  req.PageNum,
		PageSize: req.PageSize,
	})

	res = &v1.FeedArticleRes{
		List: output.Data,
	}

	res.CurrentPage = req.PageNum
	res.Total = output.Total
	res.Pages = output.Pages

	return
}

// 文章详情
func (c *cFeed) ArticleDetail(ctx context.Context, req *v1.FeedArticleDetailReq) (res *v1.FeedArticleDetailRes, err error) {
	output, err := service.Feed().ArticleDetail(ctx, model.FeedActicleInput{
		AID: req.AID,
	})

	res = &v1.FeedArticleDetailRes{
		IsLike:      output.IsLike,
		CommentList: output.Comments,
		LikeList:    output.Likes,
	}

	return
}

// 评论文章
func (c *cFeed) ArticleComment(ctx context.Context, req *v1.FeedArticleCommentReq) (res *v1.FeedArticleCommentRes, err error) {
	output, err := service.Feed().ArticleComment(ctx, model.FeedActicleCommentInput{
		AID:     req.AID,
		Comment: req.Comment,
	})

	res = &v1.FeedArticleCommentRes{
		Success: output.Success,
	}

	return
}

// 点赞/取消点赞 评论/文章
func (c *cFeed) GiveLike(ctx context.Context, req *v1.FeedGiveLikeReq) (res *v1.FeedGiveLikeRes, err error) {
	output, err := service.Feed().GiveLike(ctx, model.FeedActicleGiveLikeInput{
		Type:   req.Type,
		TypeId: req.TypeId,
	})

	res = &v1.FeedGiveLikeRes{
		Success: output.Success,
	}

	return
}

// 我发布的文章列表
func (c *cFeed) MineArticleList(ctx context.Context, req *v1.FeedArticleReq) (res *v1.FeedArticleRes, err error) {
	output, err := service.Feed().MineArticleList(ctx, model.FeedActicleListInput{
		PageNum:  req.PageNum,
		PageSize: req.PageSize,
	})

	res = &v1.FeedArticleRes{
		List: output.Data,
	}

	res.CurrentPage = req.PageNum
	res.Total = output.Total
	res.Pages = output.Pages

	return
}

// 我点赞的文章列表
func (c *cFeed) MineLikeArticleList(ctx context.Context, req *v1.FeedArticleReq) (res *v1.FeedArticleRes, err error) {
	output, err := service.Feed().MineLikeArticleList(ctx, model.FeedActicleListInput{
		PageNum:  req.PageNum,
		PageSize: req.PageSize,
	})

	res = &v1.FeedArticleRes{
		List: output.Data,
	}

	res.CurrentPage = req.PageNum
	res.Total = output.Total
	res.Pages = output.Pages

	return
}
