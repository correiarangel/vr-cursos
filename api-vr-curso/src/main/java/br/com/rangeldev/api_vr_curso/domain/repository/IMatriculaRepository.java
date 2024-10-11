package br.com.rangeldev.api_vr_curso.domain.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import br.com.rangeldev.api_vr_curso.domain.entitties.Matricula;


public interface IMatriculaRepository extends JpaRepository<Matricula, Long> {

}
