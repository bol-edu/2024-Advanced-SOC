import numpy as np
from PIL import Image
import cv2

def add_gaussian_noise(image_path, output_path, mean=0, stddev=25):
    
    image = Image.open(image_path)
    image_array = np.array(image)

    noise = np.random.normal(mean, stddev, image_array.shape)

    noisy_image_array = image_array + noise

    noisy_image_array = np.clip(noisy_image_array, 0, 255).astype(np.uint8)

    noisy_image = Image.fromarray(noisy_image_array)

    noisy_image.save(output_path)

def add_salt_and_pepper_noise(image_path, output_path, salt_prob=0.01, pepper_prob=0.01):
    image = Image.open(image_path)
    image_array = np.array(image)

    num_salt = np.ceil(salt_prob * image_array.size)
    coords = [np.random.randint(0, i - 1, int(num_salt)) for i in image_array.shape]
    image_array[coords[0], coords[1]] = 255

    num_pepper = np.ceil(pepper_prob * image_array.size)
    coords = [np.random.randint(0, i - 1, int(num_pepper)) for i in image_array.shape]
    image_array[coords[0], coords[1]] = 0

    noisy_image = Image.fromarray(image_array)

    noisy_image.save(output_path)

def reduce_edge_variation(image_path, output_path, kernel_size=5):
    image = cv2.imread(image_path)

    blurred_image = cv2.GaussianBlur(image, (kernel_size, kernel_size), 0)

    cv2.imwrite(output_path, blurred_image)


def enhance_edge_variation(image_path, output_path, alpha=1.5, beta=1.0):
    image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)
    sobelx = cv2.Sobel(image, cv2.CV_64F, 1, 0, ksize=3)
    sobely = cv2.Sobel(image, cv2.CV_64F, 0, 1, ksize=3)
    sobel = np.hypot(sobelx, sobely)
    sobel = np.uint8(sobel / np.max(sobel) * 255)
    enhanced_image = cv2.addWeighted(image, alpha, sobel, beta, 0)
    cv2.imwrite(output_path, enhanced_image)



input_image_path = './people_gray.bmp'  
output_image_path = './people_gray_reduce_edge_variation.bmp'  
reduce_edge_variation(input_image_path, output_image_path)
