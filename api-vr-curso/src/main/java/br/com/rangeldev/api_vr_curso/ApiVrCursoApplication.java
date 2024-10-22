package br.com.rangeldev.api_vr_curso;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.servers.Server;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

//@OpenAPIDefinition(servers = {@Server(url = "/", description = "Defuult Server URL")})
@SpringBootApplication
public class ApiVrCursoApplication {

	public static void main(String[] args) {
		SpringApplication.run(ApiVrCursoApplication.class, args);
		System.out.println("API VR CURSO -/// RUN "+"\nSwagger Docs: http://localhost:8080/swagger-ui/index.html# ");
	}

}