import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '@/views/Login.vue'
import Layout from '@/views/Layout.vue'
import { checkLogin } from '@/api/login/login.js'
import { getUserInfo } from '@/utils/storage.js'
import routesConfig from '@/config/routes.json'

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
      component: Login 
    },
    { 
      path: '/layout', 
      component: Layout, 
      children: []
    }
  ]
})

// 配置游客可以访问的界面
const touristVisitUrl = ['/login']

// 全局路由前置守卫
router.beforeEach(async (to, from, next) => {
  if (touristVisitUrl.includes(to.path)) {
    next()
  } else {
    const userInfo = getUserInfo()
    const result = await checkLogin(userInfo)
    if (result.data.code == 0) {
      next('/login')
      Vue.prototype.$message.error('登录超时，请重新登录！')
    } else {
      // 动态添加路由
      if (!router.hasRoute('dynamicRoutes')) {
        const dynamicRoutes = routesConfig.routes
        dynamicRoutes.forEach(route => {
          const component = () => import(`@/views/${route.component}.vue`)
          router.addRoute('layout', { ...route, component })
        })
        router.addRoute({ name: 'dynamicRoutes', path: '*', redirect: '/home' })
      }
      next()
    }
  }
})

export default router