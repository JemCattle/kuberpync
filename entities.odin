package kuberpync

import "core:encoding/json"
import "core:os"
import "core:strings"

stat :: enum {
    INT,
    REF,
    TECH,
    COOL,
    ATTR,
    LUCK,
    MOVE,
    BODY,
    EMP,
}

role :: enum {
    SOLO,
    ROCKER,
    NETRUNNER,
    MEDIA,
    NOMAD,
    FIXER,
    COP,
    CORP,
    TECHIE,
    MEDTECH,
}

character :: struct {
    name: string,
    role: [role]int,
    stats: [stat]int,
    
}

// character sheet, set name and details as fields. Stats and skills string -> int maps (i8). Equipment struct for body parts and loadout slots.
