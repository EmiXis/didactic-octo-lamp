package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

var inventario = map[string]int{
	"pollo":     5,
	"arroz":     10,
	"tomate":    4,
	"cebolla":   2,
	"ajo":       5,
	"carne_res": 0,
	"papa":      3,
	"zanahoria": 1,
	"tortilla":  20,
	"queso":     2,
}

var menu = map[string]map[string]int{
	"arroz_con_pollo": {
		"pollo":   2,
		"arroz":   3,
		"tomate":  2,
		"cebolla": 1,
		"ajo":     2,
	},
	"caldo_res": {
		"carne_res": 1,
		"papa":      2,
		"zanahoria": 2,
		"cebolla":   1,
	},
	"quesadillas": {
		"tortilla": 4,
		"queso":    1,
	},
}

func mostrarIngredientes(platillo string) {
	receta, existe := menu[platillo]
	if !existe {
		fmt.Printf("El platillo '%s' no se encuentra en el menú.\n", platillo)
		return
	}
	fmt.Printf("\n📖 Receta para [%s]:\n", strings.ToUpper(platillo))
	for ingrediente, cantidad := range receta {
		fmt.Printf("  • %s: %d requerido(s)\n", ingrediente, cantidad)
	}
}

func evaluarGuiso(platillo string) {
	receta, existe := menu[platillo]
	if !existe {
		fmt.Printf("El platillo '%s' no se encuentra en el menú.\n", platillo)
		return
	}

	ingredientesFaltantes := make(map[string]int)
	puedeCocinarse := true

	fmt.Printf("\n🍳 Analizando viabilidad para [%s]...\n", strings.ToUpper(platillo))

	for ingrediente, cantRequerida := range receta {
		cantDisponible := inventario[ingrediente]
		if cantDisponible < cantRequerida {
			puedeCocinarse = false
			ingredientesFaltantes[ingrediente] = cantRequerida - cantDisponible
		}
	}

	if puedeCocinarse {
		fmt.Println("¡Todo listo! Existen todos los ingredientes necesarios en el inventario para preparar este guiso.")
	} else {
		fmt.Println("ALERTA: No se puede cocinar. Faltan ingredientes.")
		fmt.Println("Lista de ingredientes faltantes a comprar:")
		for ing, faltante := range ingredientesFaltantes {
			fmt.Printf("  • %s -> Falta(n): %d (Requerido: %d | Disponible: %d)\n",
				ing, faltante, receta[ing], inventario[ing])
		}
	}
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	for {
		fmt.Println("\n==================================================")
		fmt.Println("   SISTEMA EXPERTO DE COCINA - CONTROL DE MENÚ")
		fmt.Println("==================================================")
		fmt.Println("1. Mostrar platillos disponibles en el menú")
		fmt.Println("2. Ver qué ingredientes lleva un guiso")
		fmt.Println("3. Verificar disponibilidad e ingredientes faltantes")
		fmt.Println("4. Salir")
		fmt.Print("Seleccione una opción: ")

		scanner.Scan()
		opcion := strings.TrimSpace(scanner.Text())

		switch opcion {
		case "1":
			fmt.Println("\n📋 Platillos en el Menú:")
			for platillo := range menu {
				fmt.Printf("  - %s\n", platillo)
			}
		case "2":
			fmt.Print("Ingrese el nombre del guiso: ")
			scanner.Scan()
			platillo := strings.ToLower(strings.TrimSpace(scanner.Text()))
			mostrarIngredientes(platillo)
		case "3":
			fmt.Print("Ingrese el nombre del guiso a evaluar: ")
			scanner.Scan()
			platillo := strings.ToLower(strings.TrimSpace(scanner.Text()))
			evaluarGuiso(platillo)
		case "4":
			fmt.Println("Saliendo del sistema experto.")
			return
		default:
			fmt.Println("Opción no válida.")
		}
	}
}
