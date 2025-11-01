#ruta: project/tests/test_calculator.py
"""
Tests for the Calculator class.
"""
import pytest
import sys
from pathlib import Path

# Add src directory to path
sys.path.insert(0, str(Path(__file__).parent.parent / 'src')) # = project/src

from calculator import Calculator


@pytest.mark.api
def test_add():
    """Test that the add method works correctly."""
    calc = Calculator() # Create an instance of Calculator
    result = calc.add(2, 3)
    assert result == 5, f"Expected 5, but got {result}"
    
    # Test with negative numbers
    result = calc.add(-1, 1)
    assert result == 0, f"Expected 0, but got {result}"
    
    # Test with floats
    result = calc.add(2.5, 3.5)
    assert result == pytest.approx(6.0), f"Expected approximately 6.0, but got {result}"


def test_get_exchange_rate(monkeypatch):
    """
    Test the get_exchange_rate method using monkeypatch to mock external API call.
    
    This test demonstrates how to use monkeypatch to isolate the function
    from its external dependency (simulated API call).
    """
    # Create a Calculator instance
    calc = Calculator()
    
    # Define a mock function that returns a predictable, fake value
    def mock_exchange_rate(currency):
        """Mock function that returns a controlled value."""
        return 3.5
    
    # Use monkeypatch to replace the get_exchange_rate method with our mock
    monkeypatch.setattr(calc, 'get_exchange_rate', mock_exchange_rate)
    
    # Call the method - it should now return our mocked value
    result = calc.get_exchange_rate('USD')
    
    # Verify that the mocked value is returned (3.5, not the real value of 2.0)
    assert result == pytest.approx(3.5), f"Expected 3.5 from mocked method, but got {result}"
    
    # Test with a different currency to verify the mock works consistently
    result_eur = calc.get_exchange_rate('EUR')
    assert result_eur == pytest.approx(3.5), f"Expected 3.5 from mocked method, but got {result_eur}"


def test_get_exchange_rate_connection_error(monkeypatch):
    """
    Test that get_exchange_rate handles ConnectionError correctly.
    
    This test demonstrates how to use monkeypatch to simulate an exception
    from an external dependency without actually triggering the real error condition.
    """
    # Create a Calculator instance
    calc = Calculator()
    
    # Use monkeypatch to replace the `get_exchange_rate` method on the Calculator
    # class so that any call will raise a ConnectionError. We set it on the class and
    # pass `raising=True` so monkeypatch verifies the attribute exists before replacing it.
    # Define a small function that raises the ConnectionError and attach it
    # to the class. This avoids using generator tricks and is clearer.
    def raise_connection_error(self, currency):
        raise ConnectionError("Simulated network failure")

    monkeypatch.setattr(Calculator, 'get_exchange_rate', raise_connection_error, raising=True)
    
    # Use pytest.raises to verify that calling the method raises a ConnectionError
    with pytest.raises(ConnectionError) as exc_info:
        calc.get_exchange_rate('USD')
    
    # Optionally, verify the exception message
    assert "Simulated network failure" in str(exc_info.value)
    
    # Test with another currency to ensure the mock consistently raises the error
    with pytest.raises(ConnectionError):
        calc.get_exchange_rate('GBP')


