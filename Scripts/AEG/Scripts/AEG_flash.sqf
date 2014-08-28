/*
    File: AEG_flash.sqf
    Version: 1.01
    Author: Loyalguard

    Description:
    A script to cause an arc flash explosion and effects.

    Parameters:
    _this select 0: The name of the AEG object (object).

    Execution:
    Executed either from a PVEH for the public variable AEG_arc or directly from AEG_actions.sqf if SP or MP host.
*/

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_flash.sqf: Thread started for:", (_this select 0)] call LGD_fnc_debugMessage;}; 

// Scope //
private ["_name", "_logicStr", "_logic", "_pos", "_b1", "_b2", "_fire", "_sparks", "_light", "_sound"];

// Parameter(s)//
_name = (_this select 0);

// Determine which game logic is co-located with the AEG object where the arc flash should occur.
_logicStr = (format ["AEG_logic_%1", _name]);
_logic = missionNameSpace getVariable _logicStr;

// Record the position of the game logic at this location for particle effects.
_pos = position _logic;

// If SP, a MP Host, or Dedicated Server then cause an explosion.
if (isServer) then
{
    // Create an "arc flash" explosion slightly above the game logic's location by colliding a place holder object with a grenade.
    _b2 = "Bomb" createVehicleLocal [(_pos select 0), (_pos select 1), ((_pos select 2) + 1.5)];
    _b2 setPos [(_pos select 0), (_pos select 1), ((_pos select 2) + 1.5)];
    _b1 = "Grenade" createVehicleLocal [(_pos select 0), (_pos select 1), ((_pos select 2) + 1.5)];
    sleep 0.05;
    deleteVehicle _b2;

    // If explosion occurs then make the object "inoperational" and ensure the new state is broadcast to all clients. 
    _opStr  = format ["AEG_op_%1", _name];
    missionNameSpace setVariable [_opStr, false];
    publicVariable _opStr;

    // Create fire sounds
    _sound = createSoundSource ["Sound_Fire", [(_pos select 0), (_pos select 1), ((_pos select 2) + 1.5)], [], 0];
};

// If SP, MP Host, or MP Client then create arc flash related particle effects (electrical arc, electrical fire, and sparks).
if (!isDedicated) then
{
    // ARC //

    // Create an "electrical arc" effect at the game logic's location.
    drop
    [
        "\ca\data\blesk1", //ShapeName
        "", //AnimationName
        "Spaceobject", //Type
        0.01, //TimerPeriod
        0.2, //LifeTime
        [(_pos select 0), (_pos select 1), ((_pos select 2) + 1.5)], // Position
        [0,0,0], //MoveVelocity
        0, //RotationVelocity
        0, //Weight
        0, //Volume
        0, //Rubbing
        [0.25], //Size
        [[1,1,1,1],[1,1,1,0.5],[1,1,1,0.1]], //Color
        [1,0], //AnimationPhase
        0, //RandomDirectionPeriod
        0, //RandomDirectionIntensity
        "", //OnTimer  
        "", //BeforeDestroy
        "" //Object
    ];

    // FIRE //

    // Create an electrical fire slightly above the game logic's location.
    _fire = "#particlesource" createVehicleLocal [(_pos select 0), (_pos select 1), ((_pos select 2) + 1.5)];
    _fire setParticleCircle [0, [0, 0, 0]];
    _fire setParticleRandom
    [
        0, //LifeTime
        [.1, .1, .1], //Position
        [0.05,0.05,0.05], //moveVelocity
        0, //rotationVelocity
        0.06, //size
        [0, 0, 0, 0], //color
        0, // randomDirectionPeriod
        0 // randomDirectionIntensity
    ];
    _fire setParticleParams
    [
        ["\ca\Data\ParticleEffects\Universal\Universal", 16, 10, 32], //ShapeName 
        "", //AnimationName
        "Billboard", //Type
        1, //TimerPeriod
        0.3, // LifeTime
        [0, 0, 0], //Position
        [0, 0, 0.17], //MoveVelocity
        0, //RotationVelocity
        10, //Weight
        7.9, //Volume
        1, //Rubbing
        [.25, .5], //Size
        [[1, 1, 1, 1], [0, 0, 0, 0]], //Color
        [0.5, 1], //AnimationPhase // 
        1, //RandomDirectionPeriod
        0, //RandomDirectionIntensity
        "", //OnTimer  
        "", //BeforeDestroy
        "" //Object
    ];
    _fire setDropInterval 0.02;

    //LIGHT//

    // Create a light source for the fire.
    _light = "#lightpoint" createVehicleLocal _pos;
    _light setLightAmbient [0.8, 0.6, 0.2];
    _light setLightColor [1, 0.5, 0.4];

    // SPARKS//

    // Create spark effects slightly above the game logic's location.
    _sparks = "#particlesource" createVehicleLocal [(_pos select 0), (_pos select 1), ((_pos select 2) + 1.5)];;
    _sparks setParticleCircle [0, [0, 0, 0]];
    _sparks setParticleRandom
    [
        0, //LifeTime
        [.1, .1, .1], //Position
        [3,3,3], //moveVelocity
        0, //rotationVelocity
        0.01, //size
        [0, 0, 0, 0], //color
        0, // randomDirectionPeriod
        0 // randomDirectionIntensity
    ];
    _sparks setParticleParams
    [
        ["\ca\Data\ParticleEffects\Universal\Universal", 16, 0, 1, 0], //ShapeName
        "", //AnimationName
        "Billboard", //Type
        1, //TimerPeriod
        (6 * random + 3), // LifeTime
        [0, 0, 0], //Position
        [0,0,0], //MoveVelocity
        1, //RotationVelocity
        0.010, //Weight
        0.0042, //Volume
        0.05, //Rubbing
        [0.1], //Size
        [[1, 1, 1, -1], [0, 0, 0, 0]], //Color
        [0, 1], //AnimationPhase
        .3, //RandomDirectionPeriod
        .3, //RandomDirectionIntensity
        "", //OnTimer  
        "", //BeforeDestroy
        "" //Object
    ];
    _sparks setDropInterval 0.0125;

    // END EFFECTS//
    //Add Pauses to allow particles to continue for a short period and stagger off.

    sleep 4;

    // End Sound (SP and MP Host only).
    if (isServer) then {deleteVehicle _sound;};
    sleep 1;

    // End Fire.
    deleteVehicle _fire;
    sleep .25;

    // End Sparks.
    deleteVehicle _sparks;
    sleep .25;

    // End Light.
    deleteVehicle _light;
};

// End sound effect if a dedicated server since above deleteVehicle is not run on dedicated servers.
if (isDedicated) then {sleep 4; deleteVehicle _sound;};

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_flash.sqf: Thread finished for:", (_this select 0)] call LGD_fnc_debugMessage;}; 