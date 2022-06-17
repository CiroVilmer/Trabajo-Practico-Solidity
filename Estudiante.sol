// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract TrabajoSolidity {

    //Creo las variables
    string private _nombre;
    string private _apellido;
    string private _curso;
    address private _docente;
    mapping (string => uint8) private notas_materias;
    string[] private _nom_materias;

    //Creo el constructor con las variables creadas arriba
    constructor(string memory nombre_, string memory apellido_, string memory curso_) {

        _nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        _docente = msg.sender;
    }

    //Devuelve el apellido del estudiante como string
    function apellido() public view returns (string memory) {

        return _apellido;
    }

    //Concatena strings para poder devolvelos.
    function AppendString(string memory a, string memory b, string memory c) public pure returns (string memory) {

        return string(abi.encodePacked(a,b,c));
    }


    //Devuelve el nombre y apellido del estudiante como un string
    function nombre_completo() public view returns (string memory) {

        //Devuelve un string concatenado(a, b, c)
        return AppendString(_nombre, " ", _apellido);
    }

    //Devuelve el curso del estudiante como string
    function curso() public view returns (string memory) {

        return _curso;
    }

    //Permite al docente asignar el valor notas_materias a nota donde la key es la materia.
    function set_nota_materia(string memory _materia, uint8 _nota) public {

        //Te requiere que la nota sea mayor a 1 y menor a 100 y tambien te requiere que el docente sea el que utiliza la función
        require(_nota >= 1 && _nota <= 100, "La nota debe ser mayor a 1 y menor a 100");
        require(_docente == msg.sender, "Solo el docente puede cambiar la nota");
        //Asigna los valores a notas_materias
        notas_materias[_materia] = _nota;
        _nom_materias.push(_materia);
    }

    //Devuelve la nota del Estudiante dada una materia.
    function nota_materia(string memory _materia) public view returns (uint) {

        uint _nota = notas_materias[_materia];   
        return _nota;
    }
    
    //Devuelve True solo si el alumno está aprobado en la materia(Más de 60%). 
    function aprobo(string memory _materia) public view returns (bool) {

        if (notas_materias[_materia] <= 60){

            return false;
        } else {

            return true;
        }
    }

    //Devuelve el promedio del alumno
    function promedio() public view returns (uint) {

        uint _notasPromedio;
        uint _numDeMaterias = _nom_materias.length;
        uint _promedio;
        //Un bucle para pasar por todas las materias
        for (uint i = 0; i < _numDeMaterias; i++){

            //Va sumando todas las notas a _notasPromedio
            _notasPromedio += notas_materias[_nom_materias[i]];
        }
        //Hace la cuenta del promedio
        _promedio = _notasPromedio / _numDeMaterias;
        return _promedio;
    }
}