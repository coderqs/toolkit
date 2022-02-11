#ifndef TOOLKIT__MEMORY__SMARTPTR_H
#define TOOLKIT__MEMORY__SMARTPTR_H
#include <utility>

template<typename T>
class SharedPtr {
public:
    SharedPtr(): m_count(new size_t), m_ptr(nullptr) {
        m_count = 1;
    }

    ~SharedPtr()
    {
        --(*m_count);
        if (0 == *m_count) {
            delete m_count, m_count = nullptr;
            delete m_ptr, m_ptr = nullptr;
        }
    }
    // 拷贝构造
    SharedPtr(const SharedPtr& ptr) {
        m_count = ptr.m_count;
        m_ptr = ptr.m_ptr;
        ++(*m_count);
    }
    // 移动构造
    SharedPtr(SharedPtr&& ptr) : m_count(ptr.m_count), m_ptr(ptr.m_ptr){
        ++(*m_count);
    }
    // 赋值
    void operator= (const SharedPtr& ptr) {
        m_count = ptr.m_count;
        m_ptr = ptr.m_ptr;
        ++(*m_count);
    }
    // 移动赋值
    void operator= (SharedPtr&& ptr) {
        SharedPtr(std::move(ptr));
    }
    // 解引用
    T& operator*() {
        return *m_ptr;
    }
    // 箭头
    T* operator->() {
        return m_ptr;
    }
    // 
    operator bool() {
        return m_ptr != nullptr;
    }

    T* Get() {
        return m_ptr;
    }
    void Reset(T* ptr) {
        --(*m_count);
        if (0 == *m_count) {
            delete m_count, m_count = nullptr;
            delete m_ptr, m_ptr = nullptr;
        }
        SharedPtr<T> p(ptr);
        *this = p;
    }

private:
    size_t* m_count;
    T* m_ptr;
};

#endif // TOOLKIT__MEMORY__SMARTPTR_H