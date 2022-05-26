package v1

import (
	"go-social/internal/model"

	"github.com/gogf/gf/v2/frame/g"
)

type FeedArticleReq struct {
	g.Meta `method:"post" tags:"FeedService" summary:"获取首页信息流"`
	ListReq
}
type FeedArticleRes struct {
	List []*model.FeedArticle `json:"list"      description:"当前页内容"`
	ListRes
}

type FeedPostArticleReq struct {
	g.Meta   `method:"post" tags:"FeedService" summary:"发布文章"`
	Title    string `p:"title" v:"required|length:6,30#标题必填|标题长度应当在6到30之间"`
	Content  string `p:"content" v:"required|length:6,2000#内容必填|内容长度应当在6到2000之间"`
	ImageUrl string `p:"imageUrl"`
}
type FeedPostArticleRes struct {
	Success bool `json:"success"      description:"发布结果"`
}

type FeedArticleDetailReq struct {
	g.Meta `method:"post" tags:"FeedService" summary:"文章详情"`
	AID    int `p:"articleId" v:"required|min:0         # 文章id必传"`
}
type FeedArticleDetailRes struct {
	IsLike      bool                    `json:"isLike"      description:"是否点赞"`
	LikeList    []*model.ArticleLike    `json:"likeList"      description:"点赞信息列表"`
	CommentList []*model.ArticleComment `json:"commentList"      description:"评论信息列表"`
}

type FeedArticleCommentReq struct {
	g.Meta  `method:"post" tags:"FeedService" summary:"添加评论"`
	AID     int    `p:"articleId" v:"required|min:0         # 文章id必传"`
	Comment string `p:"comment" v:"required|length:6,200#评论必填|评论长度应当在6到200之间"`
}
type FeedArticleCommentRes struct {
	Success bool `json:"success"      description:"评论结果"`
}

type FeedGiveLikeReq struct {
	g.Meta `method:"post" tags:"FeedService" summary:"点赞/取消点赞"`
	Type   int `p:"type" v:"required|min:0         # 类型必传"`
	TypeId int `p:"typeId" v:"required|min:0         # 类型id必传"`
}
type FeedGiveLikeRes struct {
	Success bool `json:"success"      description:"操作结果"`
}

type FeedMinePostReq struct {
	g.Meta `method:"post" tags:"FeedService" summary:"我发布的文章"`
	*ListReq
}
type FeedMinePostRes struct {
	List []*model.FeedArticle `json:"list"      description:"当前页内容"`
	ListRes
}
