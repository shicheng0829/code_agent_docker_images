#!/usr/bin/env python3

import sys
import os

# Add the python directory to the path
sys.path.insert(0, './python')

# Import the required modules at module level
from libsvm.svmutil import *

def test_python_bindings():
    """Test the Python bindings for LIBSVM"""
    print("Testing Python bindings...")
    
    try:
        # Load data
        y, x = svm_read_problem('heart_scale')
        print("✓ Data loaded successfully")
        
        # Train model
        m = svm_train(y[:200], x[:200], '-c 4')
        print("✓ Model trained successfully")
        
        # Predict
        p_label, p_acc, p_val = svm_predict(y[200:], x[200:], m)
        print("✓ Prediction completed successfully")
        print(f"✓ Test accuracy: {p_acc[0]:.2f}%")
        
        return True
        
    except Exception as e:
        print(f"✗ Python bindings test failed: {e}")
        return False

def test_cli_tools():
    """Test the CLI tools"""
    print("\nTesting CLI tools...")
    
    try:
        # Test svm-train
        os.system('./svm-train heart_scale > /dev/null 2>&1')
        print("✓ svm-train works correctly")
        
        # Test svm-predict
        result = os.system('./svm-predict heart_scale heart_scale.model heart_scale.out > /dev/null 2>&1')
        if result == 0:
            print("✓ svm-predict works correctly")
        else:
            print("✗ svm-predict failed")
            return False
            
        # Test svm-scale
        os.system('./svm-scale -l -1 -u 1 heart_scale > heart_scale.scaled 2>/dev/null')
        if os.path.exists('heart_scale.scaled'):
            print("✓ svm-scale works correctly")
        else:
            print("✗ svm-scale failed")
            return False
            
        return True
        
    except Exception as e:
        print(f"✗ CLI tools test failed: {e}")
        return False

def main():
    """Main test function"""
    print("Running comprehensive LIBSVM tests...\n")
    
    # Test Python bindings
    python_success = test_python_bindings()
    
    # Test CLI tools
    cli_success = test_cli_tools()
    
    # Summary
    print("\n" + "="*50)
    if python_success and cli_success:
        print("🎉 All tests passed! LIBSVM is working correctly.")
        return 0
    else:
        print("❌ Some tests failed. Please check the output above.")
        return 1

if __name__ == "__main__":
    sys.exit(main())