package com.example.demo

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class HelloController {

    @GetMapping("/")
    fun hello(): Map<String, String> {
        return mapOf(Pair("Hello", "Hello"))

    }
}