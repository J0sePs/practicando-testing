#ruta: proyecto/src/calculadora.py
"""
Calculator module with basic arithmetic operations.
"""


class Calculator:
    """A simple calculator class with basic arithmetic operations."""
    
    def add(self, a, b):
        """
        Add two numbers.
        
        Args:
            a: First number
            b: Second number
            
        Returns:
            The sum of a and b
        """
        return a + b
    
    def subtract(self, a, b):
        """
        Subtract two numbers.
        
        Args:
            a: First number
            b: Second number
            
        Returns:
            The difference of a and b
        """
        return a - b
    
    def get_exchange_rate(self, currency):
        """
        Get the exchange rate for a given currency.
        This simulates an external API call.
        
        Args:
            currency: The currency code (e.g., 'USD', 'EUR')
            
        Returns:
            The exchange rate as a float
            
        Raises:
            ConnectionError: If there's a connection problem (e.g., for 'EUR')
        """
        # Simulating an external API call
        # In a real scenario, this would make an HTTP request
        if currency == 'USD':
            return 2.0
        elif currency == 'EUR':
            # Simulate a connection error for EUR
            raise ConnectionError("Failed to connect to exchange rate API for EUR")
        else:
            return 1.0
