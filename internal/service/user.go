package service

import (
	"context"

	"go-social/internal/model"
	"go-social/internal/model/entity"
	"go-social/internal/service/internal/dao"
	"go-social/internal/service/internal/do"

	"github.com/gogf/gf/v2/crypto/gmd5"
	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/os/gtime"
	"github.com/gogf/gf/v2/util/gconv"
)

type (
	// sUser is service struct of module User.
	sUser struct{}
)

var (
	// insUser is the instance of service User.
	insUser = sUser{}
)

// User returns the interface of User service.
func User() *sUser {
	return &insUser
}

// 创建用户
func (s *sUser) Create(ctx context.Context, in model.UserCreateInput) (err error) {
	// If Nickname is not specified, it then uses Phone as its default Nickname.
	if in.Nickname == "" {
		in.Nickname = in.Phone
	}
	var (
		available bool
	)
	// Phone checks.
	available, err = s.IsPhoneAvailable(ctx, in.Phone)
	if err != nil {
		return err
	}
	if !available {
		return gerror.Newf(`手机号"%s" 已注册`, in.Phone)
	}
	// Nickname checks.
	available, err = s.IsNicknameAvailable(ctx, in.Nickname)
	if err != nil {
		return err
	}
	if !available {
		return gerror.Newf(`昵称 "%s" 已注册`, in.Nickname)
	}

	// pwd md5
	pwdMd5, err := gmd5.Encrypt(in.Password)
	if err != nil {
		return err
	}

	return dao.User.Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {

		_, err = dao.User.Ctx(ctx).Data(do.User{
			Phone:      in.Phone,
			PassWord:   pwdMd5,
			NickName:   in.Nickname,
			CreateTime: gtime.Now().TimestampMilli(),
			UpdateTime: gtime.Now().TimestampMilli(),
		}).Insert()
		return err
	})
}

// 登录
func (s *sUser) SignIn(ctx context.Context, in model.UserSignInInput) (user *entity.User, err error) {
	// pwd md5
	pwdMd5, err := gmd5.Encrypt(in.Password)
	if err != nil {
		return nil, err
	}
	// phone check
	available, err := s.IsPhoneAvailable(ctx, in.Phone)
	if err != nil {
		return nil, err
	}
	if available {
		return nil, gerror.New("用户未注册")
	}

	err = dao.User.Ctx(ctx).Where(do.User{
		Phone:    in.Phone,
		PassWord: pwdMd5,
	}).Scan(&user)
	if err != nil {
		return nil, err
	}
	if user == nil {
		return nil, gerror.New("密码错误")
	}

	// if err = Session().SetUser(ctx, user); err != nil {
	// 	return user, err
	// }
	// Context().SetUser(ctx, &model.ContextUser{
	// 	Phone:    user.Phone,
	// 	Nickname: user.NickName,
	// })
	return
}

// 获取用户详细信息
func (s *sUser) GetProfile(ctx context.Context) (ou *model.UserProfileOuput, err error) {
	uid := gconv.Int(Auth().GetIdentity(ctx))

	err = dao.User.Ctx(ctx).Where(do.User{
		Id: uid,
	}).Scan(&ou)

	if err != nil {
		return
	}

	// 查询文章数量
	count, err := dao.Article.Ctx(ctx).Where(do.Article{
		Uid:   uid,
		State: 1,
	}).Count()

	if err != nil {
		return
	}
	ou.ArticleNum = count

	// 查询点赞数量
	likes, err := dao.Praise.Ctx(ctx).Where(do.Praise{
		Uid:   uid,
		State: 1,
	}).Count()

	if err != nil {
		return
	}
	ou.LikesNum = likes

	// 查询被点赞数量
	liked, err := dao.Praise.Ctx(ctx).Where(do.Praise{
		ToUid: uid,
		State: 1,
	}).Count()

	if err != nil {
		return
	}
	ou.LikedNum = liked
	return

}

// SignOut removes the session for current signed-in user.
func (s *sUser) SignOut(ctx context.Context) error {
	return nil
}

// 根据手机号查询用户
func (s *sUser) QueryPhone(ctx context.Context, phone string) (bool, error) {
	count, err := dao.User.Ctx(ctx).Where(do.User{
		Phone: phone,
	}).Count()
	if err != nil {
		return false, err
	}
	return count > 0, nil
}

// 检查手机号是否可以注册.
func (s *sUser) IsPhoneAvailable(ctx context.Context, phone string) (bool, error) {
	count, err := dao.User.Ctx(ctx).Where(do.User{
		Phone: phone,
	}).Count()
	if err != nil {
		return false, err
	}
	return count == 0, nil
}

// 检查昵称是否可以注册
func (s *sUser) IsNicknameAvailable(ctx context.Context, nickname string) (bool, error) {
	count, err := dao.User.Ctx(ctx).Where(do.User{
		NickName: nickname,
	}).Count()
	if err != nil {
		return false, err
	}
	return count == 0, nil
}
