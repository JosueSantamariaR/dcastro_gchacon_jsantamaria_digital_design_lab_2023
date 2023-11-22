from PIL import Image

def image_to_mif(image_path, mif_path, width, height, total_size):
    # Cargar la imagen
    img = Image.open(image_path)
    img = img.convert('L')  # Convertir a escala de grises
    img = img.resize((width, height))  # Redimensionar si es necesario

    # Crear el archivo MIF
    with open(mif_path, 'w') as mif_file:
        mif_file.write("DEPTH = {};\n".format(total_size))
        mif_file.write("WIDTH = 8;\n")
        mif_file.write("ADDRESS_RADIX = HEX;\n")
        mif_file.write("DATA_RADIX = BIN;\n")
        mif_file.write("CONTENT\n")
        mif_file.write("BEGIN\n")

        # Escribir los datos de la imagen
        address = 0
        for y in range(height):
            for x in range(width):
                if address < 10000:  # Solo los primeros 10,000 píxeles
                    pixel_value = img.getpixel((x, y))
                    mif_file.write("{:04X} : {:08b};\n".format(address, pixel_value))
                else:
                    mif_file.write("{:04X} : {:08b};\n".format(address, 0))  # Rellenar con ceros
                address += 1

        # Rellenar el resto del archivo con ceros
        while address < total_size:
            mif_file.write("{:04X} : {:08b};\n".format(address, 0))
            address += 1

        mif_file.write("END;")


# Usar la función para convertir una imagen
image_to_mif("C:\\Users\\gabos\\Desktop\\Nueva carpeta\\dcastro_gchacon_jsantamaria_digital_design_lab_2023\\ProyectoTallerNew\\Python\\imagen.png", 
             "C:\\Users\\gabos\\Desktop\\Nueva carpeta\\dcastro_gchacon_jsantamaria_digital_design_lab_2023\\ProyectoTallerNew\\ROM.mif", 
             100, 100, 32767)

