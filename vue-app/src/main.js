import Vue from 'vue'
import App from './App.vue'
import {WebCam} from 'vue-cam-vision'
import vuetify from './plugins/vuetify';
import 'roboto-fontface/css/roboto/roboto-fontface.css'
import '@mdi/font/css/materialdesignicons.css'

Vue.config.productionTip = false

Vue.component(WebCam.name, WebCam)

new Vue({
  vuetify,
  render: h => h(App)
}).$mount('#app')
