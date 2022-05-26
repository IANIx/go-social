package middleware

import (
	"go-social/internal/service"

	"github.com/gogf/gf/v2/net/ghttp"
	// "github.com/gogf/gf/v2/os/gtime"
	// "github.com/gogf/gf/v2/util/gconv"
)

func Auth(r *ghttp.Request) {
	service.Auth().MiddlewareFunc()(r)
	// jwtToken, err := v1.Auth.ParseToken(r) // 解析token
	// if err == nil {
	// 	claims := gconv.Map(jwtToken.Claims)
	// 	//当前时间 加上间隔时间 大于 过期时间，生成新的token
	// 	intervalEndTime := gtime.Now().Unix() + g.Cfg().GetInt64("token.ExpireIntervalSecond", 345600)
	// 	if intervalEndTime > gconv.Int64(claims["exp"]) {
	// 		userInfo := g.Map{
	// 			"user_id":       claims["user_id"],
	// 			"identifier":    claims["identifier"],
	// 			"identity_type": claims["identity_type"],
	// 		}
	// 		newToken, _, err := v1.Auth.TokenGenerator(userInfo)
	// 		if err != nil {
	// 			response.Resp.FailJson(r, 400, "新token生成失败")
	// 		}
	// 		//设置响应字段
	// 		r.Response.Header().Set("x-access-token", newToken)
	// 	}
	// }
	r.Middleware.Next()
}
