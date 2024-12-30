import { createRouter, createWebHistory } from 'vue-router'
import Home from '@/views/Home.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/earn',
    name: 'Earn',
    component: () => import('@/views/Earn.vue')
  },
  {
    path: '/history',
    name: 'History',
    component: () => import('@/views/History.vue')
  },
  {
    path: '/settings',
    name: 'Settings',
    component: () => import('@/views/Settings.vue')
  },
  {
    path: '/search',
    name: 'Search',
    component: () => import('@/views/Search.vue')
  },
  {
    path: '/import-token',
    name: 'ImportToken',
    component: () => import('@/views/ImportToken.vue')
  },
  {
    path: '/import-token/:network',
    name: 'ImportTokenDetails',
    component: () => import('@/views/ImportTokenDetails.vue')
  },
  {
    path: '/select-token',
    name: 'SelectToken',
    component: () => import('@/views/SelectToken.vue')
  },
  {
    path: '/send/:tokenId',
    name: 'SendToken',
    component: () => import('@/views/SendToken.vue')
  },
  {
    path: '/buy',
    name: 'Buy',
    component: () => import('@/views/Buy.vue')
  },
  {
    path: '/markets',
    name: 'Markets',
    component: () => import('@/views/Markets.vue')
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/Login.vue')
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('@/views/Register.vue')
  },
  {
    path: '/profile',
    name: 'Profile',
    component: () => import('@/views/Profile.vue')
  },
  {
    path: '/receive',
    name: 'Receive',
    component: () => import('@/views/Receive.vue')
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

export default router 