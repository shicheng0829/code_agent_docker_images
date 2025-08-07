/*
 * test_tuibox.c: Simple test suite for tuibox
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../tuibox.h"

/* Test UI struct */
ui_t test_ui;

/* Test counters */
int tests_run = 0;
int tests_passed = 0;

/* Simple function for testing */
void test_func() { }

/* Test macros */
#define TEST_ASSERT(condition, test_name) do { \
    tests_run++; \
    if (condition) { \
        tests_passed++; \
        printf("PASS: %s\n", test_name); \
    } else { \
        printf("FAIL: %s\n", test_name); \
    } \
} while(0)

/* Mock draw function for testing */
void mock_draw(ui_box_t *b, char *out){
    sprintf(out, "Mock box");
}

/* Test initialization */
void test_ui_new() {
    ui_new(0, &test_ui);
    TEST_ASSERT(test_ui.screen == 0, "ui_new initializes screen");
    TEST_ASSERT(test_ui.b.length == 0, "ui_new initializes empty box vector");
    TEST_ASSERT(test_ui.e.length == 0, "ui_new initializes empty event vector");
    ui_free(&test_ui);
}

/* Test adding a box */
void test_ui_add() {
    ui_new(0, &test_ui);
    int id = ui_add(
        1, 1, 10, 5, 0,
        NULL, 0,
        mock_draw,
        NULL, NULL,
        NULL, NULL,
        &test_ui
    );
    
    TEST_ASSERT(test_ui.b.length == 1, "ui_add adds box to vector");
    TEST_ASSERT(id == 0, "ui_add returns correct ID");
    
    ui_box_t *box = ui_get(id, &test_ui);
    TEST_ASSERT(box != NULL, "Box is not null");
    if (box != NULL) {
        TEST_ASSERT(box->x == 1, "Box x position is correct");
        TEST_ASSERT(box->y == 1, "Box y position is correct");
        TEST_ASSERT(box->w == 10, "Box width is correct");
        TEST_ASSERT(box->h == 5, "Box height is correct");
    }
    
    ui_free(&test_ui);
}

/* Test adding a text element */
void test_ui_text() {
    ui_new(0, &test_ui);
    int id = ui_text(
        5, 3, "Test",
        0,
        NULL, NULL,
        &test_ui
    );
    
    TEST_ASSERT(test_ui.b.length == 1, "ui_text adds box to vector");
    TEST_ASSERT(id == 0, "ui_text returns correct ID");
    
    ui_box_t *box = ui_get(id, &test_ui);
    TEST_ASSERT(box != NULL, "Text box is not null");
    if (box != NULL) {
        TEST_ASSERT(box->x == 5, "Text box x position is correct");
        TEST_ASSERT(box->y == 3, "Text box y position is correct");
        TEST_ASSERT(box->w == 4, "Text box width is correct (strlen of 'Test')");
        TEST_ASSERT(box->h == 1, "Text box height is correct");
    }
    
    ui_free(&test_ui);
}

/* Test key event registration */
void test_ui_key() {
    ui_new(0, &test_ui);
    
    ui_key("q", test_func, &test_ui);
    
    TEST_ASSERT(test_ui.e.length == 1, "ui_key adds event to vector");
    
    if (test_ui.e.length > 0) {
        ui_evt_t *evt = test_ui.e.data[0];
        TEST_ASSERT(evt != NULL, "Event is not null");
        if (evt != NULL) {
            TEST_ASSERT(strcmp(evt->c, "q") == 0, "Event character is correct");
        }
    }
    
    ui_free(&test_ui);
}

/* Run all tests */
int main() {
    printf("Running tuibox tests...\n\n");
    
    test_ui_new();
    test_ui_add();
    test_ui_text();
    test_ui_key();
    
    printf("\nTests completed: %d/%d passed\n", tests_passed, tests_run);
    
    if (tests_passed == tests_run) {
        printf("All tests PASSED!\n");
        return 0;
    } else {
        printf("Some tests FAILED!\n");
        return 1;
    }
}