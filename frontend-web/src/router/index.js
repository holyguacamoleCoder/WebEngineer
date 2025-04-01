import Vue from 'vue'
import VueRouter from 'vue-router'
import { checkLogin } from '@/api/login/login.js'
import { getUserInfo } from '@/utils/storage.js'

Vue.use(VueRouter)

// 解决导航栏或者底部导航tabBar中的vue-router在3.0版本以上频繁点击菜单报错的问题
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push (location) {
  return originalPush.call(this, location).catch(err => err)
}

const router = new VueRouter({
    mode: "history",
    routes: [
        { 
          path: '/', 
          redirect: '/home'
        },
        { 
          path: '/login', 
          component: () => import('@/views/Login.vue') 
        },
        { 
          path: '/layout', 
          component: () => import('@/views/Layout.vue'), 
          children: [
            { path: '/home', component: () => import('@/views/Home.vue')},
            { path: '/student', component: () => import('@/views/member/StudentManager.vue') },
            { path: '/teacher', component: () => import('@/views/member/TeacherManager.vue') },
            { path: '/course/application', component: () => import('@/views/course/CourseApplication.vue') },
            { path: '/course/examination', component: () => import('@/views/course/CourseExamination.vue') },
            { path: '/teacher/course', component: () => import('@/views/manager/TeacherCourse.vue') },
            { path: '/student/course', component: () => import('@/views/manager/StudentCourse.vue') },
            { path: '/teacher/course/detail', component: () => import('@/views/manager/TeacherCourseDetail.vue') },
            { path: '/teaching/arrangement', component: () => import('@/views/course/TeachingArrangement.vue') },
            { path: '/select/course/center', component: () => import('@/views/course/CourseSelectionCenter.vue') }
          ]
        }

    ]
})

//配置游客可以访问的界面
const touristVisitUrl = ['/login']

//全局路由前置守卫
router.beforeEach( async (to, from, next) => {
  if (touristVisitUrl.includes(to.path)) {
    next()
  } else {
    const userInfo = getUserInfo()
    const result = await checkLogin(userInfo)
    if (result.data.code == 0) {
      next('/login')
      Vue.prototype.$message.error('登录超时，请重新登录！')
    }
    next()
  }
})

export default router