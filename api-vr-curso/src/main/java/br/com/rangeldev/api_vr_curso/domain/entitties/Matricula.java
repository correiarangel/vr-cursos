package br.com.rangeldev.api_vr_curso.domain.entitties;

import java.io.Serializable;

import jakarta.persistence.*;

@Entity
@Table(name = "TB_CURSO_ALUNO")

public class Matricula implements Serializable {
    private static Long SERIAL_MATRICULA_ID =1L;

    public Matricula() {
    }

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "codigo", nullable = false, unique = true)
    private Long codigo;

    @ManyToOne
    @JoinColumn(name = "codigo_aluno", nullable = false)
    private Aluno aluno;

    @ManyToOne
    @JoinColumn(name = "codigo_curso", nullable = false)
    private Curso curso;

    public void setCodigo(Long codigo) {
        this.codigo = codigo;
    }

    public Long getCodigo() {
        return codigo;
    }

    public Aluno getAluno() {
        return aluno;
    }

    public void setAluno(Aluno aluno) {
        this.aluno = aluno;
    }

    public Curso getCurso() {
        return curso;
    }

    public void setCurso(Curso curso) {
        this.curso = curso;
    }

}
