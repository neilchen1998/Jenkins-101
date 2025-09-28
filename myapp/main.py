import numpy as np

def calculate_squares(numbers_list):
    """
    Creates a NumPy array from a list and squares every element.
    """

    numpy_array = np.array(numbers_list)

    squared_array = numpy_array ** 2
    
    return squared_array

if __name__ == "__main__":

    data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    print("--- NumPy Array Squaring Demo ---")
    
    results = calculate_squares(data)
    
    print(f"\nArray after squaring each element:\n{results}")
