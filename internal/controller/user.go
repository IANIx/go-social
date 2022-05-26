package controller

import (
	"context"

	v1 "go-social/api/v1"
	"go-social/internal/model"
	"go-social/internal/service"
	// "go-social/internal/utility"
)

var (
	User = cUser{}
)

type cUser struct{}

// 用户注册
func (c *cUser) SignUp(ctx context.Context, req *v1.UserSignUpReq) (res *v1.UserSignUpRes, err error) {
	err = service.User().Create(ctx, model.UserCreateInput{
		Phone:    req.Phone,
		Password: req.Password,
		Nickname: req.Nickname,
	})
	return
}

// 用户登录，成功返回用户信息，否则返回nil;
func (c *cUser) SignIn(ctx context.Context, req *v1.UserLoginReq) (res *v1.UserLoginRes, err error) {
	user, err := service.User().SignIn(ctx, model.UserSignInInput{
		Phone:    req.Phone,
		Password: req.Password,
	})

	token, _ := service.Auth().LoginHandler(ctx)

	res = &v1.UserLoginRes{
		Token:    token,
		Id:       user.Id,
		NickName: user.NickName,
		Avatar:   user.Avatar,
		Gender:   user.Gender,
		Type:     user.Type,
		Phone:    user.Phone,
	}

	return
}

// 用户退出登录
func (c *cUser) SignOut(ctx context.Context, req *v1.UserLogoutReq) (res *v1.UserLogoutRes, err error) {
	service.Auth().LogoutHandler(ctx)

	return
}

/// 获取用户信息
func (c *cUser) GetProfile(ctx context.Context, req *v1.UserJwtReq) (res *v1.UserProfileRes, err error) {
	ou, err := service.User().GetProfile(ctx)
	res = &v1.UserProfileRes{
		Id:         ou.Id,
		Avatar:     ou.Avatar,
		Phone:      ou.Phone,
		NickName:   ou.Nickname,
		ArticleNum: ou.ArticleNum,
		LikesNum:   ou.LikesNum,
		LikedNum:   ou.LikedNum,
	}
	return
}

/// 获取jwt信息
func (c *cUser) JwtInfo(ctx context.Context, req *v1.UserJwtReq) (res *v1.UserJwtRes, err error) {
	println("")
	res = &v1.UserJwtRes{}
	res.Token = service.Auth().GetPayload(ctx)
	return
}

// // 判断用户是否已经登录
// func (c *cLogin) IsSignedIn(session *ghttp.Session) bool {
// 	return session.Contains(USER_SESSION_MARK)
// }
