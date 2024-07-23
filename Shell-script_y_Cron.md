# Shell Scripting

## ¿Qué es?
- Es la práctica de escribir scripts o pequeños programas utilizando un shell de Unix/Linux, como Bash, sh, csh, etc. 
- Estos **scripts son secuencias de comandos que se ejecutan en el intérprete de comandos del sistema operativo**.
- El `shell` actúa como una interfaz entre el usuario y el núcleo del sistema operativo, permitiendo ejecutar comandos, programas y scripts.
- *Recordar que la extensión de un fichero no importa.*
- *Necesitamos permisos de ejecución para poder ejecutarlo*.
- **Características del Shell Scripting:**
    - **Automatización de tareas**
        - Permite automatizar tareas repetitivas, como copias de seguridad, administración de sistemas y operaciones de archivos.
    - **Secuencias de comandos** 
        - Los scripts son archivos de texto que contienen una serie de comandos que se ejecutan en orden.
    - **Variables y estructuras de control**
        - Los scripts pueden utilizar variables, bucles, condiciones y funciones, similares a otros lenguajes de programación.
    - **Facilidad de uso**
        - Es una herramienta poderosa y fácil de aprender para administradores de sistemas y usuarios avanzados.
    - **Compatibilidad:** Los scripts pueden ejecutarse en diferentes sistemas Unix/Linux con poco o ningún cambio.
- **Ejemplo**:
    ```bash
        #!/bin/bash
        # Este es un comentario
        echo "Hola, mundo!" # Imprime un mensaje en la terminal

        # Variables
        nombre="Juan"
        echo "Hola, $nombre"

        # Condicional
        if [ "$nombre" = "Juan" ]; then
            echo "Tu nombre es Juan"
        else
            echo "Tu nombre no es Juan"
        fi

        # Bucle
        for i in {1..5}; do
            echo "Número $i"
        done
    ```

## Componentes Básicos de un Shell Script
- **Shebang**: `#!/bin/bash` 
    - Indica al sistema qué intérprete de comandos usar para ejecutar el script.
- **Comentarios**: 
    - Usan `#` para agregar notas y descripciones en el código.
- **Comandos**: 
    - Instrucciones que el shell ejecuta.
- **Variables**: 
    - Almacenan datos que pueden ser reutilizados.
- **Estructuras de control**: 
    - `if, for, while, etc.,` permiten controlar el flujo del script.

## Ventajas del Shell Scripting
- **Eficiencia**: 
    - Reduce el tiempo necesario para realizar tareas repetitivas.
- **Reproducibilidad**: 
    - Las tareas pueden repetirse de manera consistente y precisa.
- **Flexibilidad**: 
    - Puede integrarse con otros programas y scripts.
- **Portabilidad**: 
    - Los scripts pueden ejecutarse en diferentes entornos Unix/Linux.

## Usos comunes
- **Administración de sistemas**:
    -  Automatización de tareas administrativas.
- **Procesamiento de datos**:
    -  Manipulación y análisis de archivos de datos.
- **Despliegue de aplicaciones**:
    -  Automatización del proceso de instalación y configuración.
- **Tareas de mantenimiento**:
    -  Copias de seguridad, actualizaciones y monitoreo del sistema.

## Condicionales
### Condicional `if`
```bash
# Sintaxis
if [ condición ]; then
    # comandos
fi

#Ejemplo
#!/bin/bash
numero=10

if [ $numero -gt 5 ]; then
    echo "El número es mayor que 5"
fi
```

### Condicional `if-elif-else`
```bash
# Sintaxis
if [ condición1 ]; then
    # comandos si condición1 es verdadera
elif [ condición2 ]; then
    # comandos si condición2 es verdadera
else
    # comandos si ninguna condición es verdadera
fi

# Ejemplo
#!/bin/bash
numero=5

if [ $numero -gt 5 ]; then
    echo "El número es mayor que 5"
elif [ $numero -eq 5 ]; then
    echo "El número es igual a 5"
else
    echo "El número es menor que 5"
fi
```

### Condicional `case`
```bash
# Sintaxis
case variable in
    patrón1)
        # comandos
        ;;
    patrón2)
        # comandos
        ;;
    *)
        # comandos por defecto
        ;;
esac

# Ejemplo
#!/bin/bash
dia="lunes"

case $dia in
    "lunes")
        echo "Hoy es lunes"
        ;;
    "martes")
        echo "Hoy es martes"
        ;;
    *)
        echo "No es ni lunes ni martes"
        ;;
esac
```

### Operadores lógicos
```bash
# Sintaxis
if [ condición1 ] && [ condición2 ]; then
    # comandos si ambas condiciones son verdaderas
fi

if [ condición1 ] || [ condición2 ]; then
    # comandos si al menos una condición es verdadera
fi
```

## Bucles, iteraciones
### Bucle `for`
```bash
# Sintaxis
for variable in lista; do
    # comandos
done

# Ejemplo
#!/bin/bash
for archivo in *.txt; do
    echo "Archivo: $archivo"
done

# --------------------------------------------------

# Bucle for con C-like
for (( inicialización; condición; incremento )); do
    # comandos
done

# Ejemplo
#!/bin/bash
for (( i=1; i<=5; i++ )); do
    echo "Número: $i"
done
```

### Bucle `while`
```bash
# Sintaxis
while [ condición ]; do
    # comandos
done

# Ejemplo
#!/bin/bash
contador=1

while [ $contador -le 5 ]; do
    echo "Contador: $contador"
    contador=$((contador + 1))
done

# ------------------------------------------------- 

# Ejemplo leyendo un archivo línea por línea
#!/bin/bash
while IFS= read -r linea; do
    echo "$linea"
done < archivo.txt
```

### Bucle `select`
```bash
# Sintaxis
select variable in lista; do
    # comandos
done

# Ejemplo
#!/bin/bash
PS3="Selecciona una opción: "
select opcion in "Opción 1" "Opción 2" "Opción 3" "Salir"; do
    case $opcion in
        "Opción 1")
            echo "Seleccionaste Opción 1"
            ;;
        "Opción 2")
            echo "Seleccionaste Opción 2"
            ;;
        "Opción 3")
            echo "Seleccionaste Opción 3"
            ;;
        "Salir")
            break
            ;;
        *)
            echo "Opción inválida"
            ;;
    esac
done
```

### Bucle `break` y `continue`
```bash
#break (salir del bucle)
#!/bin/bash
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        break
    fi
    echo "Número: $i"
done

# continue (saltar a la siguiente iteración)
#!/bin/bash
for i in {1..5}; do
    if [ $i -eq 3 ]; then
        continue
    fi
    echo "Número: $i"
done
```

## Ejemplos de uso
### Peticiones de valores con `read`
```bash
#!/bin/bash
echo "Introduce tu nombre:"
read nombre
echo "Hola, $nombre!"
```

### Funciones
```bash
#!/bin/bash
# Definir una función
saludar() {
    echo "Hola, $1!"
}

# Llamar a la función
saludar "Mundo"
saludar "Juan"
```

### Procesar archvios
- Ejemplo de agregar un usuario a un usuario.
    ```bash
    #!/bin/bash
    echo "Introduce el nombre de usuario:"
    read usuario
    echo "$usuario" >> usuarios.txt
    echo "Usuario $usuario agregado a usuarios.txt"
    ```
- Ejemplo de procesar un archivo línea por línea
    ```bash
    #!/bin/bash
    while IFS= read -r linea; do
        echo "Procesando: $linea"
        # Aquí puedes agregar más lógica de procesamiento
    done < archivo.txt
    ```

### Empaquetado
```bash
#!/bin/bash
# Empaquetar archivos en un archivo tar.gz
tar -czvf mi_archivo.tar.gz archivo1.txt archivo2.txt directorio/
echo "Archivos empaquetados en mi_archivo.tar.gz"
```

### Sincronización y Backup
- Ejemplo de sincronización con `rsync`
    ```bash
    #!/bin/bash
    # Sincronizar directorios
    rsync -av --delete /ruta/origen/ /ruta/destino/
    echo "Sincronización completa"
    ```
- Ejemplo de un script de backup
    ```bash
    #!/bin/bash
    # Variables
    origen="/ruta/origen/"
    destino="/ruta/destino/backup_$(date +%Y%m%d_%H%M%S).tar.gz"

    # Crear backup
    tar -czvf "$destino" "$origen"
    echo "Backup creado en $destino"
    ```

---

<br>

# Cron 
## ¿Qué es?
- Es una utilidad de Unix/Linux que se utiliza para programar la ejecución de scripts, comandos o tareas a intervalos regulares o en momentos específicos del tiempo. 
- Es una herramienta fundamental para la automatización de tareas repetitivas en sistemas Unix/Linux.

### Características
- **Automatización de Tareas**: 
    - Permite programar tareas como copias de seguridad, limpieza de archivos temporales, sincronización de datos, etc.
- **Flexibilidad en la Programación**: 
    - Se puede programar tareas para que se ejecuten a intervalos regulares (cada minuto, hora, día, semana, mes) o en momentos específicos.
- **Bajo Consumo de Recursos**: 
    - Es ligero y eficiente, no consume muchos recursos del sistema.
- **Granularidad en la Programación**: 
    - Permite especificar con gran detalle cuándo se deben ejecutar las tareas.

### ¿Cómo funciona?
- Cron utiliza un archivo especial llamado `crontab` (abreviatura de cron table) para gestionar la programación de tareas. 
- Cada usuario en el sistema puede tener su propio archivo crontab, y también hay un crontab del sistema administrado por el superusuario.

## Crontab
- Es un archivo especial que contiene las definiciones de las tareas programadas.

### Comandos relacionado
- `crontab -e`
    - Permite editar el archivo crontab del usuario actual
- `crontab -l`
    - Muestra el contenido del archivo crontab del usuario actual
- `crontab -r`
    - Elimina el archivo crontab del usuario actual
- `/etc/crontab`
    - El archivo crontab a nivel de sistema que adefine tareas para todos los usuarios.

### Campos crontab
```scss
*     *     *     *     *  comando a ejecutar
-     -     -     -     -
|     |     |     |     |
|     |     |     |     +----- día de la semana (0 - 7) (domingo es tanto 0 como 7)
|     |     |     +------- mes (1 - 12)
|     |     +--------- día del mes (1 - 31)
|     +----------- hora (0 - 23)
+------------- minuto (0 - 59)
```
- **Descripción campos**
    - `Minuto (0 - 59)`:  
        - Especifica el minuto del día en el que se ejecutará el comando.
        - Ejemplo: 30 significa que se ejecutará en el minuto 30 de cada hora.
    - `Hora (0 - 23)`:    
        - Especifica la hora del día en formato de 24 horas.
        - Ejemplo: 14 significa que se ejecutará a las 2 PM.
    - `Día del mes (1 - 31)`: 
        - Especifica el día del mes en que se ejecutará el comando.
        - Ejemplo: 15 significa que se ejecutará el día 15 de cada mes.
    - `Mes (1 - 12)`: 
        - Especifica el mes del año en que se ejecutará el comando.
        - Ejemplo: 6 significa que se ejecutará en junio.
    - `Día de la semana (0 - 7)`: 
        - Especifica el día de la semana en que se ejecutará el comando. Tanto 0 como 7 representan el domingo.
        - Ejemplo: 3 significa que se ejecutará el miércoles.    

- **Caracteres especiales en Crontab**
 - `Asterisco (*)`:
    - Representa "cada" unidad de tiempo.
    - Ejemplo: * * * * * significa que el comando se ejecutará cada minuto de cada hora de cada día de cada mes.
 - `Coma (,)`:
    - Se usa para separar valores individuales.
    - Ejemplo: 1,15 en el campo del día del mes significa el día 1 y el día 15.
 - `Guion (-)`:
    - Define un rango de valores.
    - Ejemplo: 1-5 en el campo de día de la semana significa de lunes a viernes.
 - `Barra diagonal (/)`:
    - Define intervalos de valores.
    - Ejemplo: */5 en el campo de minutos significa cada 5 minutos.

#### Ejemplo entrada en Crontab
- Ejecutar un comando cada minuto
    ```bash
    * * * * * /ruta/al/comando
    ```
- Ejecutar un script todos los días a las 2:30 AM
    ```bash
    30 2 * * * /ruta/al/script.sh
    ```
- Ejecutar un comando todos los lunes a las 3:00 PM
    ```bash
   0 15 * * 1 /ruta/al/comando
    ```
- Ejecutar un script el primer día de cada mes a medianoche
    ```bash
    0 0 1 * * /ruta/al/script.sh
    ```
- Ejecutar un script cada 15 minutos.
    ```bash
    */15 * * * * /ruta/al/script.sh
    ```
- Ejecutar un script de lunes a viernes a las 10:00 AM
    ```bash
    0 10 * * 1-5 /ruta/al/script.sh
    ```




























