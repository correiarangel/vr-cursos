package br.com.rangeldev.api_vr_curso.controller;

import br.com.rangeldev.api_vr_curso.controller.dto.MatriculaDTO;

import br.com.rangeldev.api_vr_curso.domain.entitties.Matricula;
import br.com.rangeldev.api_vr_curso.service.IMatriculaSevice;
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
@RequestMapping("/api-vr/v1/enrollments")
@Tag(name = "Enrollments Controller", description = "RESTful API for managing enrollment.")
public record MatriculaController(IMatriculaSevice matriculaSevice) {

        @GetMapping
        @Operation(summary = "Get all enrollments", description = "Retrieve a list of all enrollments ")
        @ApiResponses(value = {
                        @ApiResponse(responseCode = "200", description = "Operation Successful ;)")
        })
        public ResponseEntity<List<MatriculaDTO>> findAll() {

                List<Matricula> matriculas = matriculaSevice.findAll();
                List<MatriculaDTO> dtos = matriculas.stream()
                                .map((Matricula m) -> new MatriculaDTO(m.getCodigo(), m.getCurso(), m.getAluno()))
                                .collect(Collectors.toList());

                return ResponseEntity.ok((List<MatriculaDTO>) dtos);
        }

        @GetMapping("/{id}")
        @Operation(summary = "Get a enrollments by ID", description = "Retrieve a specific enrollments based on its ID")
        @ApiResponses(value = {
                        @ApiResponse(responseCode = "200", description = "Operation Successful ;)"),
                        @ApiResponse(responseCode = "404", description = "enrollments not found")
        })
        public ResponseEntity<MatriculaDTO> findById(@PathVariable Long id) {
                Matricula m = matriculaSevice.findById(id);
                return ResponseEntity.ok(new MatriculaDTO(m.getCodigo(), m.getCurso(), m.getAluno()));
        }

        @PostMapping
        @Operation(summary = "Create a new enrollment", description = "Create a new enrollments and return the created enrollment's data")
        @ApiResponses(value = {
                        @ApiResponse(responseCode = "201", description = "Registered created successfully"),
                        @ApiResponse(responseCode = "422", description = "Invalid enrollments data provided")
        })
        public ResponseEntity<MatriculaDTO> create(@RequestBody MatriculaDTO matriculaDTO) {
                Matricula m = matriculaSevice.create(matriculaDTO.toEntity());
                URI location = ServletUriComponentsBuilder.fromCurrentRequest()
                                .path("/{id}")
                                .buildAndExpand(m.getCodigo())
                                .toUri();
                return ResponseEntity.created(location).body(new MatriculaDTO(
                                m.getCodigo(),
                                m.getCurso(),
                                m.getAluno()));
        }

        @PutMapping("/{id}")
        @Operation(summary = "Update a enrollment", description = "Update the data of an existing enrollment based on its ID")
        @ApiResponses(value = {
                        @ApiResponse(responseCode = "200", description = "Enrollment updated successfully"),
                        @ApiResponse(responseCode = "404", description = "Enrollment not found"),
                        @ApiResponse(responseCode = "422", description = "Invalid registered data provided")
        })
        public ResponseEntity<MatriculaDTO> update(@PathVariable Long id, @RequestBody MatriculaDTO matriculaDTO) {
                Matricula m = matriculaSevice.create(matriculaDTO.toEntity());
                return ResponseEntity.ok(new MatriculaDTO(
                        m.getCodigo(),
                        m.getCurso(),
                        m.getAluno()));
        }

        @DeleteMapping("/{id}")
        @Operation(summary = "Delete a Enrollment", description = "Delete an existing Enrollment based on its ID")
        @ApiResponses(value = {
                        @ApiResponse(responseCode = "204", description = "Enrollment deleted successfully"),
                        @ApiResponse(responseCode = "404", description = "Enrollment not found")
        })
        public ResponseEntity<Void> delete(@PathVariable Long id) {
                matriculaSevice.delete(id);
                return ResponseEntity.noContent().build();
        }
}
