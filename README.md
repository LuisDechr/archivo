# Mi primer programa para GitHub

def saludar(nombre):
    return f"¡Hola, {nombre}! Bienvenido a GitHub."

def main():
    print("=== Mi Primer Proyecto en GitHub ===")
    nombre = input("¿Cómo te llamas? ")
    print(saludar(nombre))

if __name__ == "__main__":
    main()
