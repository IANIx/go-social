package middleware

import "github.com/gogf/gf/v2/net/ghttp"

func Cors(r *ghttp.Request) {
	r.Response.CORSDefault()
	r.Middleware.Next()
}

// Ctx injects custom business context variable into context of current request.
func Ctx(r *ghttp.Request) {
	// customCtx := &model.Context{
	// 	Session: r.Session,
	// }
	// Context().Init(r, customCtx)
	// if user := Session().GetUser(r.Context()); user != nil {
	// 	// customCtx.User = &model.ContextUser{
	// 	// 	Id:       user.Id,
	// 	// 	Passport: user.Passport,
	// 	// 	Nickname: user.Nickname,
	// 	// }
	// }
	// Continue execution of next middleware.
	r.Middleware.Next()
}
