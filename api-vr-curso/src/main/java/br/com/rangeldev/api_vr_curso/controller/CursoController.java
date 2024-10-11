package br.com.rangeldev.api_vr_curso.controller;

import br.com.rangeldev.api_vr_curso.controller.dto.CursoDTO;
import br.com.rangeldev.api_vr_curso.domain.entitties.Curso;
import br.com.rangeldev.api_vr_curso.service.ICursoService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;
import java.util.stream.Collectors;

@CrossOrigin
@RestController
@RequestMapping("/api-vr/v1/courses")
@Tag(name = "Courses Controller", description = "RESTful API for managing courses.")
public record CursoController(ICursoService cursoSevice) {

    @GetMapping
    @Operation(summary = "Get all courses", description = "Retrieve a list of all registered students")
    @ApiResponses(value = { 
            @ApiResponse(responseCode = "200", description = "Operation Successful ;)")
    })
    public ResponseEntity<List<CursoDTO>> findAll() {
        List<Curso>  cursos = cursoSevice.findAll();
        List<CursoDTO> dtos = cursos.stream()
                .map((Curso curso) -> new CursoDTO(
                        curso.getCodigo(),
                        curso.getDescricao(),
                        curso.getEmenta(), 
                        curso.getCursoCodigosMatriculas()
                     
                        )).collect(Collectors.toList());
       
                        return ResponseEntity.ok((List<CursoDTO>) dtos);
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get a course by ID", description = "Retrieve a specific course based on its ID")
    @ApiResponses(value = { 
            @ApiResponse(responseCode = "200", description = "Operation Successful ;)"),
            @ApiResponse(responseCode = "404", description = "course not found")
    })
    public ResponseEntity<CursoDTO> findById(@PathVariable Long id) {
        Curso curso = cursoSevice.findById(id);
        return ResponseEntity.ok(new CursoDTO(curso.getCodigo(),curso.getDescricao(),curso.getEmenta(),curso.getCursoCodigosMatriculas()));
    }

    @PostMapping
    @Operation(summary = "Create a new course", description = "Create a new courses and return the created courses's data")
    @ApiResponses(value = { 
            @ApiResponse(responseCode = "201", description = "course created successfully"),
            @ApiResponse(responseCode = "422", description = "Invalid course data provided")
    })
    public ResponseEntity<CursoDTO> create(@RequestBody CursoDTO cusoDTO) {
        Curso curso = cursoSevice.create(cusoDTO.toEntity());
        URI location = ServletUriComponentsBuilder.fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(curso.getCodigo())
                .toUri();
        return ResponseEntity.created(location).body(new CursoDTO(
                curso.getCodigo(),
                curso.getDescricao(),
                curso.getEmenta(),
                curso.getCursoCodigosMatriculas())
        );
    }

    @PutMapping("/{id}")
    @Operation(summary = "Update a course", description = "Update the data of an existing course based on its ID")
    @ApiResponses(value = { 
            @ApiResponse(responseCode = "200", description = "course updated successfully"),
            @ApiResponse(responseCode = "404", description = "course not found"),
            @ApiResponse(responseCode = "422", description = "Invalid course data provided")
    })
    public ResponseEntity<CursoDTO> update(@PathVariable Long id, @RequestBody CursoDTO cusoDTO) {
        Curso curso = cursoSevice.create(cusoDTO.toEntity());
        return ResponseEntity.ok(new CursoDTO(curso.getCodigo(),curso.getDescricao(),curso.getEmenta(),curso.getCursoCodigosMatriculas()));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Delete a course", description = "Delete an existing course based on its ID")
    @ApiResponses(value = { 
            @ApiResponse(responseCode = "204", description = "course deleted successfully"),
            @ApiResponse(responseCode = "404", description = "course not found")
    })
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        cursoSevice.delete(id);
        return ResponseEntity.noContent().build();
    }
}

