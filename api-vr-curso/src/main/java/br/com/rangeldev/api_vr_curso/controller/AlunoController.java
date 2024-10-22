package br.com.rangeldev.api_vr_curso.controller;

import br.com.rangeldev.api_vr_curso.controller.dto.AlunoDTO;
import br.com.rangeldev.api_vr_curso.domain.entitties.Aluno;
import br.com.rangeldev.api_vr_curso.service.IAlunoService;
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
@RequestMapping("/api-vr/v1/students")
@Tag(name = "Students Controller", description = "RESTful API for managing students.")
public record AlunoController(IAlunoService alunoSevice) {


    @GetMapping
    @Operation(summary = "Get all students", description = "Retrieve a list of all registered students")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Operation Successful ;)")
    })
    public ResponseEntity<List<AlunoDTO>> findAll() {
        var alunos = alunoSevice.findAll();
        var alunoDto = alunos.stream().map((Aluno aluno) -> new AlunoDTO(aluno.getCodigo(),aluno.getNome(),aluno.getAlunoCodigosMatriculas())).collect(Collectors.toList());
        return ResponseEntity.ok((List<AlunoDTO>) alunoDto);
    }

    @Operation(summary = "Get a student by ID", description = "Retrieve a specific student based on its ID")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Operation Successful ;)"),
        @ApiResponse(responseCode = "404", description = "student not found")
    })
    @GetMapping("/{id}")
    public ResponseEntity<AlunoDTO> findById(@PathVariable Long id) {
        var aluno = alunoSevice.findById(id);
        return ResponseEntity.ok(new AlunoDTO(aluno.getCodigo(),aluno.getNome(),aluno.getAlunoCodigosMatriculas()));
    }

    @PostMapping
    @Operation(summary = "Create a new student", description = "Create a new students and return the created students's data")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "User created successfully"),
            @ApiResponse(responseCode = "422", description = "Invalid student data provided")
    })
    public ResponseEntity<AlunoDTO> create(@RequestBody AlunoDTO alunoDTO) {
        var aluno = alunoSevice.create(alunoDTO.toEntity());
        URI location = ServletUriComponentsBuilder.fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(aluno.getCodigo())
                .toUri();
        return ResponseEntity.created(location).body(new AlunoDTO(aluno.getCodigo(),aluno.getNome(),aluno.getAlunoCodigosMatriculas()));
    }

    @PutMapping("/{id}")
    @Operation(summary = "Update a student", description = "Update the data of an existing student based on its ID")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "student updated successfully"),
        @ApiResponse(responseCode = "404", description = "student not found"),
        @ApiResponse(responseCode = "422", description = "Invalid student data provided")
    })
    public ResponseEntity<AlunoDTO> update(@PathVariable Long id, @RequestBody AlunoDTO alunosDto) {
        var aluno = alunoSevice.update(id, alunosDto.toEntity());
        return ResponseEntity.ok(new AlunoDTO(aluno.getCodigo(),aluno.getNome(),aluno.getAlunoCodigosMatriculas()));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Delete a student", description = "Delete an existing student based on its ID")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "204", description = "student deleted successfully"),
        @ApiResponse(responseCode = "404", description = "student not found")
    })
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        alunoSevice.delete(id);
        return ResponseEntity.noContent().build();
    }
}

