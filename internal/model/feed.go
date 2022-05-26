package model

// import "github.com/gogf/gf/v2/frame/g"

type FeedPostActicleInput struct {
	Title    string
	Content  string
	ImageUrl string
}

type FeedCommonOutput struct {
	Success bool
}

type FeedActicleListInput struct {
	PageNum  int
	PageSize int
}

type FeedActicleListOutput struct {
	Total       int
	Pages       int
	CurrentPage int
	Data        []*FeedArticle
}

type FeedActicleInput struct {
	AID int
}

type FeedActicleDetailOutput struct {
	IsLike   bool
	Likes    []*ArticleLike
	Comments []*ArticleComment
}

type FeedActicleCommentInput struct {
	AID     int
	Comment string
}

type FeedActicleGiveLikeInput struct {
	Type   int
	TypeId int
}

type FeedGiveLikeInput struct {
	Type   int
	TypeId int
	AID    int
	ToUid  int
}

type FeedArticle struct {
	Id         int    `json:"articleId"         description:"文章id"`
	Title      string `json:"title"      description:"文章标题"`
	Content    string `json:"content"    description:"文章内容"`
	Img        string `json:"img"        description:"文章图片地址"`
	CommentNum int    `json:"commentNum" description:"评论数"`
	PraiseNum  int    `json:"praiseNum"  description:"点赞数"`
	Uid        int    `json:"userId"        description:"作者id"`
	NickName   string `json:"nickName"        description:"作者昵称"`
	Avatar     string `json:"avatar"        description:"作者头像"`
	CreateTime int64  `json:"createTime" description:"创建时间"`
}

type ArticleLike struct {
	Type       int    `json:"type"         description:"点赞类型"`
	TypeId     int    `json:"typeId"         description:"文章/评论id"`
	Uid        int    `json:"userId"        description:"点赞者id"`
	NickName   string `json:"nickName"        description:"点赞者昵称"`
	Avatar     string `json:"avatar"        description:"点赞者头像"`
	CreateTime int64  `json:"createTime" description:"点赞时间"`
}

type ArticleComment struct {
	Id         int    `json:"commentId"        description:"评论id"`
	Aid        int    `json:"articleId"         description:"文章id"`
	Uid        int    `json:"userId"        description:"评论者id"`
	Comment    string `json:"comment_cont"        description:"评论内容"`
	NickName   string `json:"nickName"        description:"评论者昵称"`
	Avatar     string `json:"avatar"        description:"评论者头像"`
	CreateTime int64  `json:"createTime" description:"评论时间"`
	PraiseNum  int    `json:"like_num"         description:"点赞数"`
	IsLike     bool   `json:"isLike"         description:"是否点赞"`
}
