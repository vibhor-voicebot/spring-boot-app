package com.example.springbootapp;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
@RestController
public class APIController {
  @GetMapping("/api")
  public String index() {
    return "Welcome to Spring Boot App";
  }
  @RequestMapping(value = "/api/hello", method = RequestMethod.GET,
    produces = MediaType.APPLICATION_JSON_VALUE)
  @ResponseBody
  public String hello(@RequestParam String name) {
    String responseJson = "{ \"message\" : \"Hello "+ name + "\" }";
    return responseJson;
  }
}
