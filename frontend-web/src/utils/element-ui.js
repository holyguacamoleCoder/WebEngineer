import {
    Container, 
    Header,
    Aside,
    Main, 
    Tag,
    Form,
    FormItem,
} from 'element-ui'

const element = {
    install: function(Vue) {
        Vue.use(Container)
        Vue.use(Header)
        Vue.use(Aside)
        Vue.use(Main)
        Vue.use(Tag)
        Vue.use(Form)
        Vue.use(FormItem)
    }
}

export default element
