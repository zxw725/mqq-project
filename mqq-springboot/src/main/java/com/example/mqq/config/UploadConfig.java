package com.example.mqq.config;



import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
public class UploadConfig extends WebMvcConfigurerAdapter {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
//映射图片保存地址
        registry.addResourceHandler("/static/images/**").addResourceLocations("file:D:\\code\\project\\bishe\\mqq\\mqq\\mqq-springboot\\src\\main\\resources\\static\\images\\");
    }
}

