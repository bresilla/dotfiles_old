#pragma once
#include <string>
#include <vector>
namespace utl {
    // template<const std::string& S, const std::string& D, const bool& B>
    std::vector<std::string> split(const std::string& s, const std::string& delimiter, const bool& removeEmptyEntries = false){
        std::vector<std::string> tokens;
        for (size_t start = 0, end; start < s.length(); start = end + delimiter.length()){
            size_t position = s.find(delimiter, start);
            end = position != std::string::npos ? position : s.length();
            std::string token = s.substr(start, end - start);
            if (!removeEmptyEntries || !token.empty()) { tokens.push_back(token); }
        }
        auto endsWith = [](const std::string& s, const std::string& suffix)->bool{ return s.size() >= suffix.size() && s.substr(s.size() - suffix.size()) == suffix; };
        if (!removeEmptyEntries && (s.empty() || endsWith(s, delimiter))) { tokens.push_back(""); }
        return tokens;
    }

    int factorial(int number) { return number <= 1 ? number : factorial(number - 1) * number; }
}
