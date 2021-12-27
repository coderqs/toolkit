#ifndef TOOLKIT__DESIGNPATTERN__SINGLETON_H
#define TOOLKIT__DESIGNPATTERN__SINGLETON_H

#include <mutex>
#include <memory>

template<class T>
class Singleton {
public:
    static T* GetInstance(void) {
        if (nullptr == m_instance) {
            m_lock.lock();
            if (nullptr == m_instance)
                m_instance = std::unique_ptr<T>(new T);

            m_lock.unlock();
        }
        return m_instance.get();
    }

    Singleton(T&&) = delete;
    Singleton(const T&) = delete;
    void operator=(const T&) = delete;

protected:
    Singleton() = default;
    virtual ~Singleton() = default;

private:
    static std::mutex m_lock;
    static std::unique_ptr<T> m_instance;
};

template<class T>
std::mutex Singleton<T>::m_lock;

template<class T>
std::unique_ptr<T> Singleton<T>::m_instance = NULL;



#endif // TOOLKIT__DESIGNPATTERN__SINGLETON_H
