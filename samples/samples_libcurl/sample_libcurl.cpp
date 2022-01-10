#include <iostream>

#include "curl/curl.h"

size_t curl_writer(void* buffer, size_t size, size_t count, void* stream)
{
    std::string* pStream = static_cast<std::string*>(stream);
    (*pStream).append((char*)buffer, size * count);

    std::cout << "size: " << size << "count: " << count << std::endl << *pStream << std::endl;
    return size * count;
}

int base_libcurl(char* url, long& resp_code) {
    CURL* curl = curl_easy_init();

    curl_easy_setopt(curl, CURLOPT_URL, url);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, curl_writer);
    std::string resp;
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &resp);
    std::cout << resp << std::endl;

    int ret = curl_easy_perform(curl);
    if (CURLE_OK == ret)
    {
        ret = curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &resp_code);
    }
    else
    {
        std::cout << "http request perform failure. ec: "<< ret << std::endl;
    }
    curl_easy_cleanup(curl);

    return ret;
}

int main(int argc, char** argv) {
    char* url = "www.baidu.com";
    long resp_code = 0;
    base_libcurl(url, resp_code);
    return 0;
}