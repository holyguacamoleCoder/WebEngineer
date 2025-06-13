import request from '@/utils/request.js'

//查询所有待审批的数据
export const getWaitExamination = (examinationName) => {
    return request.get('/wait/examination?examinationName=' + examinationName)
}

//查询所有已审批的数据
export const getAlreadyExamination = (examinationName) => {
    return request.get('/already/examination?examinationName=' + examinationName)
}

//审批一条记录
export const examineACourse = (form) => {
    return request.post('/course/examination', form)
}