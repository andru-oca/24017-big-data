SELECT 
    a.email AS correo_electronico
,   CONCAT("<p>Hola  ", a.nombre , ", ", a.apellido, " </p>
    <p>Espero que este mensaje te encuentre bien. Te escribimos para informarte que hasta el momento no te has presentado al segundo examen del curso. Queremos recordarte que es importante completar todos los exámenes para obtener una calificación final.</p>
    <p>Te pedimos que realices el examen pendiente a la brevedad posible. Tienes aproximadamente una semana para completarlo.</p>
    <p>Si tienes alguna pregunta o necesitas ayuda, no dudes en ponerte en contacto con nosotros.</p>
    <p>Saludos cordiales, Colegio</p>
    ") AS mensaje_alumno

FROM modelado AS m
LEFT JOIN alumno  AS a
    ON a.id_alumno = m.id_alumno
LEFT JOIN nivel AS n 
    ON m.id_nivel = n.id_nivel
WHERE 1=1
    AND n.nivel = '1A' 
    AND a.nota_final IS NULL
    ;



SELECT 
    a.email AS correo_electronico
,   CONCAT("<div class='diploma'>
        <div class='header'>
            <h1>Diploma de Excelencia</h1>
        </div>
        <div class='content'>
            <p>Este certificado se otorga a:</p>
            <h2>", a.apellido ,", ", a.nombre," </h2>
            <p>Por su destacado desempeño académico y dedicación en el curso.</p>
            <p> Calificacion final: <strong>", a.nota_final ," <strong></p>
        </div>
        <div class='signature'>
            <p>Firma del Director</p>
        </div>
    </div>

    ") AS diploma_alumno

FROM modelado AS m
LEFT JOIN alumno  AS a
    ON a.id_alumno = m.id_alumno

WHERE 1=1
    AND a.nota_final IS NOT NULL
LIMIT 10
    ;



SELECT
    COUNT(a.id_alumno) AS total_aprobados

FROM modelado AS m
LEFT JOIN alumno  AS a
    ON a.id_alumno = m.id_alumno

WHERE 1=1
    AND a.nota_final IS NOT NULL
    AND a.nota_final > 7
    ;


SELECT
    n.nivel,
    COUNT(CASE WHEN a.nota_final >= 7 THEN 1 END) AS aprobados,
    COUNT(CASE WHEN a.nota_final < 7 AND a.nota_final >= 4 THEN 1 END) AS desaprobados,
    COUNT(CASE WHEN a.nota_final IS NULL THEN 1 END) AS ausentes
FROM alumno a
INNER JOIN modelado m ON m.id_alumno = a.id_alumno
INNER JOIN nivel n ON n.id_nivel = m.id_nivel
GROUP BY n.id_nivel, n.nivel
ORDER BY n.nivel ASC;



SELECT
    i.nombre_instructor
,   i.apellido_instructor
,   i.email_instructor
,   CONCAT(
        "<h2> Revision de nota final del alumno: <strong>", a.apellido , ", ", a.nombre 
    ,   "</strong></h2>"
) AS mensaje_instructor
FROM alumno a
INNER JOIN modelado m ON m.id_alumno = a.id_alumno
INNER JOIN instructor i ON i.id_instructor = m.id_instructor
WHERE a.nombre = 'Uta' AND a.apellido = 'Domanek';


SELECT
    i.nombre_instructor
,   i.apellido_instructor    
,   a.nombre
,   a.apellido
,   a.email

FROM modelado AS m
INNER JOIN nivel AS n
    USING(id_nivel)
INNER JOIN instructor AS i
    USING(id_instructor)
INNER JOIN alumno AS a
    USING(id_alumno)
WHERE 1 = 1 
AND    n.nivel = CAST( (SELECT MAX(nivel)
                     FROM (SELECT    
                            REGEXP_SUBSTR(nivel, '[0-9]+') AS nivel
                            FROM nivel
                    ) as nivel ) AS CHAR)

AND a.apellido REGEXP '^[M-P]'
ORDER BY i.nombre_instructor DESC, a.apellido , a.nombre ;