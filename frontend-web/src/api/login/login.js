import request from '@/utils/request.js'

//登录接口
export const login = (form) => {
   return request.post('/login', form)
}

//检查用户登录状态
export const checkLogin = (form) => {
   return request.post('/check/login', form)
}

//修改用户密码
export const modifyUserPassword = (form) => {
   return request.post('/modify/user/password', form)
}