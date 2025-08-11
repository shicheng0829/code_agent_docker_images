#!/usr/bin/env python3

"""
Test script to verify NanoGUI installation
"""

import nanogui
import sys

def test_nanogui_import():
    """Test that nanogui can be imported"""
    print("NanoGUI imported successfully!")
    # Print available attributes
    print("Available attributes:", [attr for attr in dir(nanogui) if not attr.startswith('_')])
    return True

def test_nanogui_constants():
    """Test accessing some NanoGUI constants"""
    try:
        # Try to access some basic constants or classes
        print("NanoGUI constants test:")
        print(f"  Widget: {nanogui.Widget}")
        print(f"  Screen: {nanogui.Screen}")
        print(f"  Window: {nanogui.Window}")
        return True
    except Exception as e:
        print(f"Constants test failed: {e}")
        return False

if __name__ == "__main__":
    print("Testing NanoGUI installation...")
    
    success = True
    success &= test_nanogui_import()
    success &= test_nanogui_constants()
    
    if success:
        print("\nAll tests passed!")
        sys.exit(0)
    else:
        print("\nSome tests failed!")
        sys.exit(1)