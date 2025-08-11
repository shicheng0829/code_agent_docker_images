#!/usr/bin/env python3

"""
Simple NanoGUI example
"""

import nanogui
import sys

def main():
    # Initialize NanoGUI
    nanogui.init()
    
    # Create a screen
    screen = nanogui.Screen((500, 400), "NanoGUI Example")
    
    # Create a window
    window = nanogui.Window(screen, "Example Window")
    window.setPosition((50, 50))
    window.setLayout(nanogui.GroupLayout())
    
    # Add some widgets
    nanogui.Label(window, "Welcome to NanoGUI!")
    
    # Add a button
    button = nanogui.Button(window, "Click me!")
    button.setCallback(lambda: print("Button clicked!"))
    
    # Add a checkbox
    checkbox = nanogui.CheckBox(window, "Checkbox")
    checkbox.setChecked(True)
    
    # Add a slider
    slider = nanogui.Slider(window)
    slider.setValue(0.5)
    
    # Show the screen
    screen.setVisible(True)
    screen.performLayout()
    
    # Run the main loop
    nanogui.mainloop()
    
    # Cleanup
    del screen
    nanogui.shutdown()

if __name__ == "__main__":
    main()