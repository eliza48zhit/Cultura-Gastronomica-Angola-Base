// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaAngola
 * @dev Registro de viscosidades de tubérculos y emulsiones de aceite de palma.
 * Serie: Sabores de Africa (9/54)
 */
contract CulturaAngola {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        uint256 nivelViscosidad;  // Escala de fluidez del Funge (1-10)
        bool usaAceitePalma;      // Elemento base para el Moamba
        bool esFusionLusa;        // Influencia de la gastronomia portuguesa
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Inauguramos con el Muamba de Galinha (Icono Nacional)
        registrarPlato(
            "Muamba de Galinha", 
            "Pollo, aceite de palma, quimbombo, ajo, calabaza, chile.",
            "Cocinar el pollo en una emulsion de aceite de palma y agua hasta que espese naturalmente.",
            6, 
            true, 
            true
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        uint256 _viscosidad, 
        bool _palma,
        bool _fusion
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_viscosidad <= 10, "Escala viscosidad: 1 a 10");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            nivelViscosidad: _viscosidad,
            usaAceitePalma: _palma,
            esFusionLusa: _fusion,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        uint256 viscosidad,
        bool palma,
        bool fusion,
        uint256 likes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (p.nombre, p.nivelViscosidad, p.usaAceitePalma, p.esFusionLusa, p.likes);
    }
}
