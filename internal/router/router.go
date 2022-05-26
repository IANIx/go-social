package router

import (
	"fmt"
	"go-social/internal/controller"
	"go-social/internal/middleware"

	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/net/ghttp"
)

func init() {
	fmt.Println("呵呵哒 router")
	// 用户模块 路由注册 - 使用执行对象注册方式
	s := g.Server()

	s.BindHandler("/test", func(r *ghttp.Request) {
		r.Response.Writeln(123)
	})
	s.Group("/v1", func(group *ghttp.RouterGroup) {

		//跨域路由，不需要登陆
		group.Group("/", func(group *ghttp.RouterGroup) {
			group.Middleware(
				middleware.Ctx,
				middleware.Cors)

			group.POST("/user/login", controller.User.SignIn)     // 手机号密码登陆
			group.POST("/user/signUp", controller.User.SignUp)    // 注册
			group.POST("/feed/list", controller.Feed.ArticleList) // 查询文章列表
		})

		//跨域路由，需要登陆
		group.Group("/", func(group *ghttp.RouterGroup) {
			group.Middleware(middleware.Cors,
				middleware.Auth)

			group.POST("/user/jwt_info", controller.User.JwtInfo)   // jwt信息
			group.POST("/user/profile", controller.User.GetProfile) // 获取用户信息
			group.POST("/user/logout", controller.User.SignOut)     // 用户退出登录

			group.POST("/feed/post", controller.Feed.PostArticle)               // 发布文章
			group.POST("/feed/article/detail", controller.Feed.ArticleDetail)   // 文章详情
			group.POST("/feed/article/comment", controller.Feed.ArticleComment) // 发布文章评论
			group.POST("/feed/giveLike", controller.Feed.GiveLike)              // 点赞/取消点赞

			group.POST("/feed/mineLike", controller.Feed.MineLikeArticleList) // 我点赞的文章
			group.POST("/feed/mine", controller.Feed.MineArticleList)         // 我发布的文章

		})
	})
}
