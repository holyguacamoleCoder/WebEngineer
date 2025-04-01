import request from '@/utils/request.js'

//查询学院信息
export const getDepartmentInfo = () => {
    return request.get('/departments')
}

// 查询教师信息
export const getTeachersInfo = (queryTeacherParam) => {
    return request.post('/teachers', queryTeacherParam)
}

// 新增一条教师信息
export const insertTeacherInfo = (form) => {
    return request.post('/teacher', form)
}   

//根据id删除教师信息
export const deleteTeacherInfo = (teacherId) => {
    return request.delete('/teachers/' + teacherId)
}

//根据id查询教师信息
export const getTeacherInfoById = (teacherId) => {
    return request.get('/get/teacher?teacherId=' + teacherId)
}

//修改教师信息（后端根据id进行修改）
export const updateTeacherInfoById = (form) => {
    return request.put('/modify/teacher', form)
}

//获取所有教师的信息
export const getAllTeacher = () => {
    return request.get('/get/teachers')
}