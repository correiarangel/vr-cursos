package br.com.rangeldev.api_vr_curso.domain.repository;


import br.com.rangeldev.api_vr_curso.domain.entitties.Aluno;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IAlunoRepository extends JpaRepository<Aluno,Long>{

}
