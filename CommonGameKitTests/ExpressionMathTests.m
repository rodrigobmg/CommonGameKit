/*
 *  Copyright (c) 2016, Stefan Johnson
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without modification,
 *  are permitted provided that the following conditions are met:
 *
 *  1. Redistributions of source code must retain the above copyright notice, this list
 *     of conditions and the following disclaimer.
 *  2. Redistributions in binary form must reproduce the above copyright notice, this
 *     list of conditions and the following disclaimer in the documentation and/or other
 *     materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ExpressionEvaluatorTests.h"

@interface ExpressionMathTests : ExpressionEvaluatorTests

@end

@implementation ExpressionMathTests

-(void) testAddition
{
    ExpressionResult Test[] = {
        { "(+)",            CCExpressionValueTypeExpression },
        { "(+ 1)",          CCExpressionValueTypeInteger,   .integer = 1 },
        { "(+ -1)",         CCExpressionValueTypeInteger,   .integer = -1 },
        { "(+ 1.5)",        CCExpressionValueTypeFloat,     .real = 1.5f },
        { "(+ -1.5)",       CCExpressionValueTypeFloat,     .real = -1.5f },
        { "(+ .test)",       CCExpressionValueTypeExpression },
        { "(+ .i)",          CCExpressionValueTypeInteger,   .integer = -5 },
        { "(+ .f)",          CCExpressionValueTypeFloat,     .real = -2.5f },
        { "(+ \"string\")", CCExpressionValueTypeExpression },
        { "(+ ())",         CCExpressionValueTypeExpression },
        
        { "(+ 1 2)",        CCExpressionValueTypeInteger,   .integer = 1 + 2 },
        { "(+ 1 -2)",       CCExpressionValueTypeInteger,   .integer = 1 + -2 },
        { "(+ -1 2)",       CCExpressionValueTypeInteger,   .integer = -1 + 2 },
        { "(+ -1 -2)",      CCExpressionValueTypeInteger,   .integer = -1 + -2 },
        { "(+ 1 .i)",        CCExpressionValueTypeInteger,   .integer = 1 + i },
        { "(+ -1 .i)",       CCExpressionValueTypeInteger,   .integer = -1 + i },
        { "(+ 1.5 2.5)",    CCExpressionValueTypeFloat,     .real = 1.5 + 2.5 },
        { "(+ 1.5 -2.5)",   CCExpressionValueTypeFloat,     .real = 1.5 + -2.5 },
        { "(+ -1.5 2.5)",   CCExpressionValueTypeFloat,     .real = -1.5 + 2.5 },
        { "(+ -1.5 -2.5)",  CCExpressionValueTypeFloat,     .real = -1.5 + -2.5 },
        { "(+ 1.5 .f)",      CCExpressionValueTypeFloat,     .real = 1.5 + f },
        { "(+ -1.5 .f)",     CCExpressionValueTypeFloat,     .real = -1.5 + f },
        
        { "(+ 1 2.5)",      CCExpressionValueTypeFloat,     .real = 1 + 2.5 },
        { "(+ 1.5 2)",      CCExpressionValueTypeFloat,     .real = 1.5 + 2 },
        { "(+ -1 2.5)",     CCExpressionValueTypeFloat,     .real = -1 + 2.5 },
        { "(+ -1.5 2)",     CCExpressionValueTypeFloat,     .real = -1.5 + 2 },
        { "(+ 1 -2.5)",     CCExpressionValueTypeFloat,     .real = 1 + -2.5 },
        { "(+ 1.5 -2)",     CCExpressionValueTypeFloat,     .real = 1.5 + -2 },
        { "(+ -1 -2.5)",    CCExpressionValueTypeFloat,     .real = -1 + -2.5 },
        { "(+ -1.5 -2)",    CCExpressionValueTypeFloat,     .real = -1.5 + -2 },
        { "(+ 1 .f)",        CCExpressionValueTypeFloat,     .real = 1 + f },
        { "(+ 1.5 .i)",      CCExpressionValueTypeFloat,     .real = 1.5 + i },
        
        { "(+ .test 1)",     CCExpressionValueTypeExpression },
        { "(+ \"s\" 1)",    CCExpressionValueTypeExpression },
        { "(+ () 1)",       CCExpressionValueTypeExpression },
        { "(+ 1 .test)",     CCExpressionValueTypeExpression },
        { "(+ 1 \"s\")",    CCExpressionValueTypeExpression },
        { "(+ 1 ())",       CCExpressionValueTypeExpression },
        { "(+ .test 1.0)",   CCExpressionValueTypeExpression },
        { "(+ \"s\" 1.0)",  CCExpressionValueTypeExpression },
        { "(+ () 1.0)",     CCExpressionValueTypeExpression },
        { "(+ 1.0 .test)",   CCExpressionValueTypeExpression },
        { "(+ 1.0 \"s\")",  CCExpressionValueTypeExpression },
        { "(+ 1.0 ())",     CCExpressionValueTypeExpression },
        
        { "(+ 1 2 9)",      CCExpressionValueTypeInteger,   .integer = 1 + 2 + 9 },
        { "(+ 1 -2 9)",     CCExpressionValueTypeInteger,   .integer = 1 + -2 + 9 },
        { "(+ -1 2 9)",     CCExpressionValueTypeInteger,   .integer = -1 + 2 + 9 },
        { "(+ -1 -2 9)",    CCExpressionValueTypeInteger,   .integer = -1 + -2 + 9 },
        { "(+ 1 .i 9)",      CCExpressionValueTypeInteger,   .integer = 1 + i + 9 },
        { "(+ -1 .i 9)",     CCExpressionValueTypeInteger,   .integer = -1 + i + 9 },
        { "(+ 1.5 2.5 9)",  CCExpressionValueTypeFloat,     .real = 1.5 + 2.5 + 9 },
        { "(+ 1.5 -2.5 9)", CCExpressionValueTypeFloat,     .real = 1.5 + -2.5 + 9 },
        { "(+ -1.5 2.5 9)", CCExpressionValueTypeFloat,     .real = -1.5 + 2.5 + 9 },
        { "(+ -1.5 -2.5 9)",CCExpressionValueTypeFloat,     .real = -1.5 + -2.5 + 9 },
        { "(+ 1.5 .f 9)",    CCExpressionValueTypeFloat,     .real = 1.5 + f + 9 },
        { "(+ -1.5 .f 9)",   CCExpressionValueTypeFloat,     .real = -1.5 + f + 9 },
        
        { "(+ (+ 1 2) (+ 9 5))",    CCExpressionValueTypeInteger, .integer = (1 + 2) + (9 + 5) },
        { "(+ (+ 1.0 2) (+ 9 5))",  CCExpressionValueTypeFloat,   .real = (1.0f + 2) + (9 + 5) },
        { "(+ (+ 1 2) (+ 9.0 5))",  CCExpressionValueTypeFloat,   .real = (1 + 2) + (9.0f + 5) },
        { "(+ (+ .test 2) (+ 9 5))", CCExpressionValueTypeExpression }
    };
    
    
    [self assert: Test count: sizeof(Test) / sizeof(*Test)];
}

-(void) testSubstraction
{
    ExpressionResult Test[] = {
        { "(-)",            CCExpressionValueTypeExpression },
        { "(- 1)",          CCExpressionValueTypeInteger,   .integer = 1 },
        { "(- -1)",         CCExpressionValueTypeInteger,   .integer = -1 },
        { "(- 1.5)",        CCExpressionValueTypeFloat,     .real = 1.5f },
        { "(- -1.5)",       CCExpressionValueTypeFloat,     .real = -1.5f },
        { "(- .test)",       CCExpressionValueTypeExpression },
        { "(- .i)",          CCExpressionValueTypeInteger,   .integer = -5 },
        { "(- .f)",          CCExpressionValueTypeFloat,     .real = -2.5f },
        { "(- \"string\")", CCExpressionValueTypeExpression },
        { "(- ())",         CCExpressionValueTypeExpression },
        
        { "(- 1 2)",        CCExpressionValueTypeInteger,   .integer = 1 - 2 },
        { "(- 1 -2)",       CCExpressionValueTypeInteger,   .integer = 1 - -2 },
        { "(- -1 2)",       CCExpressionValueTypeInteger,   .integer = -1 - 2 },
        { "(- -1 -2)",      CCExpressionValueTypeInteger,   .integer = -1 - -2 },
        { "(- 1 .i)",        CCExpressionValueTypeInteger,   .integer = 1 - i },
        { "(- -1 .i)",       CCExpressionValueTypeInteger,   .integer = -1 - i },
        { "(- 1.5 2.5)",    CCExpressionValueTypeFloat,     .real = 1.5 - 2.5 },
        { "(- 1.5 -2.5)",   CCExpressionValueTypeFloat,     .real = 1.5 - -2.5 },
        { "(- -1.5 2.5)",   CCExpressionValueTypeFloat,     .real = -1.5 - 2.5 },
        { "(- -1.5 -2.5)",  CCExpressionValueTypeFloat,     .real = -1.5 - -2.5 },
        { "(- 1.5 .f)",      CCExpressionValueTypeFloat,     .real = 1.5 - f },
        { "(- -1.5 .f)",     CCExpressionValueTypeFloat,     .real = -1.5 - f },
        
        { "(- 1 2.5)",      CCExpressionValueTypeFloat,     .real = 1 - 2.5 },
        { "(- 1.5 2)",      CCExpressionValueTypeFloat,     .real = 1.5 - 2 },
        { "(- -1 2.5)",     CCExpressionValueTypeFloat,     .real = -1 - 2.5 },
        { "(- -1.5 2)",     CCExpressionValueTypeFloat,     .real = -1.5 - 2 },
        { "(- 1 -2.5)",     CCExpressionValueTypeFloat,     .real = 1 - -2.5 },
        { "(- 1.5 -2)",     CCExpressionValueTypeFloat,     .real = 1.5 - -2 },
        { "(- -1 -2.5)",    CCExpressionValueTypeFloat,     .real = -1 - -2.5 },
        { "(- -1.5 -2)",    CCExpressionValueTypeFloat,     .real = -1.5 - -2 },
        { "(- 1 .f)",        CCExpressionValueTypeFloat,     .real = 1 - f },
        { "(- 1.5 .i)",      CCExpressionValueTypeFloat,     .real = 1.5 - i },
        
        { "(- .test 1)",     CCExpressionValueTypeExpression },
        { "(- \"s\" 1)",    CCExpressionValueTypeExpression },
        { "(- () 1)",       CCExpressionValueTypeExpression },
        { "(- 1 .test)",     CCExpressionValueTypeExpression },
        { "(- 1 \"s\")",    CCExpressionValueTypeExpression },
        { "(- 1 ())",       CCExpressionValueTypeExpression },
        { "(- .test 1.0)",   CCExpressionValueTypeExpression },
        { "(- \"s\" 1.0)",  CCExpressionValueTypeExpression },
        { "(- () 1.0)",     CCExpressionValueTypeExpression },
        { "(- 1.0 .test)",   CCExpressionValueTypeExpression },
        { "(- 1.0 \"s\")",  CCExpressionValueTypeExpression },
        { "(- 1.0 ())",     CCExpressionValueTypeExpression },
        
        { "(- 1 2 9)",      CCExpressionValueTypeInteger,   .integer = 1 - 2 - 9 },
        { "(- 1 -2 9)",     CCExpressionValueTypeInteger,   .integer = 1 - -2 - 9 },
        { "(- -1 2 9)",     CCExpressionValueTypeInteger,   .integer = -1 - 2 - 9 },
        { "(- -1 -2 9)",    CCExpressionValueTypeInteger,   .integer = -1 - -2 - 9 },
        { "(- 1 .i 9)",      CCExpressionValueTypeInteger,   .integer = 1 - i - 9 },
        { "(- -1 .i 9)",     CCExpressionValueTypeInteger,   .integer = -1 - i - 9 },
        { "(- 1.5 2.5 9)",  CCExpressionValueTypeFloat,     .real = 1.5 - 2.5 - 9 },
        { "(- 1.5 -2.5 9)", CCExpressionValueTypeFloat,     .real = 1.5 - -2.5 - 9 },
        { "(- -1.5 2.5 9)", CCExpressionValueTypeFloat,     .real = -1.5 - 2.5 - 9 },
        { "(- -1.5 -2.5 9)",CCExpressionValueTypeFloat,     .real = -1.5 - -2.5 - 9 },
        { "(- 1.5 .f 9)",    CCExpressionValueTypeFloat,     .real = 1.5 - f - 9 },
        { "(- -1.5 .f 9)",   CCExpressionValueTypeFloat,     .real = -1.5 - f - 9 },
        
        { "(- (- 1 2) (- 9 5))",    CCExpressionValueTypeInteger, .integer = (1 - 2) - (9 - 5) },
        { "(- (- 1.0 2) (- 9 5))",  CCExpressionValueTypeFloat,   .real = (1.0f - 2) - (9 - 5) },
        { "(- (- 1 2) (- 9.0 5))",  CCExpressionValueTypeFloat,   .real = (1 - 2) - (9.0f - 5) },
        { "(- (- .test 2) (- 9 5))", CCExpressionValueTypeExpression }
    };
    
    
    [self assert: Test count: sizeof(Test) / sizeof(*Test)];
}

-(void) testMultiplication
{
    ExpressionResult Test[] = {
        { "(*)",            CCExpressionValueTypeExpression },
        { "(* 1)",          CCExpressionValueTypeInteger,   .integer = 1 },
        { "(* -1)",         CCExpressionValueTypeInteger,   .integer = -1 },
        { "(* 1.5)",        CCExpressionValueTypeFloat,     .real = 1.5f },
        { "(* -1.5)",       CCExpressionValueTypeFloat,     .real = -1.5f },
        { "(* .test)",       CCExpressionValueTypeExpression },
        { "(* .i)",          CCExpressionValueTypeInteger,   .integer = -5 },
        { "(* .f)",          CCExpressionValueTypeFloat,     .real = -2.5f },
        { "(* \"string\")", CCExpressionValueTypeExpression },
        { "(* ())",         CCExpressionValueTypeExpression },
        
        { "(* 1 2)",        CCExpressionValueTypeInteger,   .integer = 1 * 2 },
        { "(* 1 -2)",       CCExpressionValueTypeInteger,   .integer = 1 * -2 },
        { "(* -1 2)",       CCExpressionValueTypeInteger,   .integer = -1 * 2 },
        { "(* -1 -2)",      CCExpressionValueTypeInteger,   .integer = -1 * -2 },
        { "(* 1 .i)",        CCExpressionValueTypeInteger,   .integer = 1 * i },
        { "(* -1 .i)",       CCExpressionValueTypeInteger,   .integer = -1 * i },
        { "(* 1.5 2.5)",    CCExpressionValueTypeFloat,     .real = 1.5 * 2.5 },
        { "(* 1.5 -2.5)",   CCExpressionValueTypeFloat,     .real = 1.5 * -2.5 },
        { "(* -1.5 2.5)",   CCExpressionValueTypeFloat,     .real = -1.5 * 2.5 },
        { "(* -1.5 -2.5)",  CCExpressionValueTypeFloat,     .real = -1.5 * -2.5 },
        { "(* 1.5 .f)",      CCExpressionValueTypeFloat,     .real = 1.5 * f },
        { "(* -1.5 .f)",     CCExpressionValueTypeFloat,     .real = -1.5 * f },
        
        { "(* 1 2.5)",      CCExpressionValueTypeFloat,     .real = 1 * 2.5 },
        { "(* 1.5 2)",      CCExpressionValueTypeFloat,     .real = 1.5 * 2 },
        { "(* -1 2.5)",     CCExpressionValueTypeFloat,     .real = -1 * 2.5 },
        { "(* -1.5 2)",     CCExpressionValueTypeFloat,     .real = -1.5 * 2 },
        { "(* 1 -2.5)",     CCExpressionValueTypeFloat,     .real = 1 * -2.5 },
        { "(* 1.5 -2)",     CCExpressionValueTypeFloat,     .real = 1.5 * -2 },
        { "(* -1 -2.5)",    CCExpressionValueTypeFloat,     .real = -1 * -2.5 },
        { "(* -1.5 -2)",    CCExpressionValueTypeFloat,     .real = -1.5 * -2 },
        { "(* 1 .f)",        CCExpressionValueTypeFloat,     .real = 1 * f },
        { "(* 1.5 .i)",      CCExpressionValueTypeFloat,     .real = 1.5 * i },
        
        { "(* .test 1)",     CCExpressionValueTypeExpression },
        { "(* \"s\" 1)",    CCExpressionValueTypeExpression },
        { "(* () 1)",       CCExpressionValueTypeExpression },
        { "(* 1 .test)",     CCExpressionValueTypeExpression },
        { "(* 1 \"s\")",    CCExpressionValueTypeExpression },
        { "(* 1 ())",       CCExpressionValueTypeExpression },
        { "(* .test 1.0)",   CCExpressionValueTypeExpression },
        { "(* \"s\" 1.0)",  CCExpressionValueTypeExpression },
        { "(* () 1.0)",     CCExpressionValueTypeExpression },
        { "(* 1.0 .test)",   CCExpressionValueTypeExpression },
        { "(* 1.0 \"s\")",  CCExpressionValueTypeExpression },
        { "(* 1.0 ())",     CCExpressionValueTypeExpression },
        
        { "(* 1 2 9)",      CCExpressionValueTypeInteger,   .integer = 1 * 2 * 9 },
        { "(* 1 -2 9)",     CCExpressionValueTypeInteger,   .integer = 1 * -2 * 9 },
        { "(* -1 2 9)",     CCExpressionValueTypeInteger,   .integer = -1 * 2 * 9 },
        { "(* -1 -2 9)",    CCExpressionValueTypeInteger,   .integer = -1 * -2 * 9 },
        { "(* 1 .i 9)",      CCExpressionValueTypeInteger,   .integer = 1 * i * 9 },
        { "(* -1 .i 9)",     CCExpressionValueTypeInteger,   .integer = -1 * i * 9 },
        { "(* 1.5 2.5 9)",  CCExpressionValueTypeFloat,     .real = 1.5 * 2.5 * 9 },
        { "(* 1.5 -2.5 9)", CCExpressionValueTypeFloat,     .real = 1.5 * -2.5 * 9 },
        { "(* -1.5 2.5 9)", CCExpressionValueTypeFloat,     .real = -1.5 * 2.5 * 9 },
        { "(* -1.5 -2.5 9)",CCExpressionValueTypeFloat,     .real = -1.5 * -2.5 * 9 },
        { "(* 1.5 .f 9)",    CCExpressionValueTypeFloat,     .real = 1.5 * f * 9 },
        { "(* -1.5 .f 9)",   CCExpressionValueTypeFloat,     .real = -1.5 * f * 9 },
        
        { "(* (* 1 2) (* 9 5))",    CCExpressionValueTypeInteger, .integer = (1 * 2) * (9 * 5) },
        { "(* (* 1.0 2) (* 9 5))",  CCExpressionValueTypeFloat,   .real = (1.0f * 2) * (9 * 5) },
        { "(* (* 1 2) (* 9.0 5))",  CCExpressionValueTypeFloat,   .real = (1 * 2) * (9.0f * 5) },
        { "(* (* .test 2) (* 9 5))", CCExpressionValueTypeExpression }
    };
    
    
    [self assert: Test count: sizeof(Test) / sizeof(*Test)];
}

-(void) testDivision
{
    ExpressionResult Test[] = {
        { "(/)",            CCExpressionValueTypeExpression },
        { "(/ 1)",          CCExpressionValueTypeInteger,   .integer = 1 },
        { "(/ -1)",         CCExpressionValueTypeInteger,   .integer = -1 },
        { "(/ 1.5)",        CCExpressionValueTypeFloat,     .real = 1.5f },
        { "(/ -1.5)",       CCExpressionValueTypeFloat,     .real = -1.5f },
        { "(/ .test)",       CCExpressionValueTypeExpression },
        { "(/ .i)",          CCExpressionValueTypeInteger,   .integer = -5 },
        { "(/ .f)",          CCExpressionValueTypeFloat,     .real = -2.5f },
        { "(/ \"string\")", CCExpressionValueTypeExpression },
        { "(/ ())",         CCExpressionValueTypeExpression },
        
        { "(/ 1 2)",        CCExpressionValueTypeInteger,   .integer = 1 / 2 },
        { "(/ 1 -2)",       CCExpressionValueTypeInteger,   .integer = 1 / -2 },
        { "(/ -1 2)",       CCExpressionValueTypeInteger,   .integer = -1 / 2 },
        { "(/ -1 -2)",      CCExpressionValueTypeInteger,   .integer = -1 / -2 },
        { "(/ 1 .i)",        CCExpressionValueTypeInteger,   .integer = 1 / i },
        { "(/ -1 .i)",       CCExpressionValueTypeInteger,   .integer = -1 / i },
        { "(/ 1.5 2.5)",    CCExpressionValueTypeFloat,     .real = 1.5 / 2.5 },
        { "(/ 1.5 -2.5)",   CCExpressionValueTypeFloat,     .real = 1.5 / -2.5 },
        { "(/ -1.5 2.5)",   CCExpressionValueTypeFloat,     .real = -1.5 / 2.5 },
        { "(/ -1.5 -2.5)",  CCExpressionValueTypeFloat,     .real = -1.5 / -2.5 },
        { "(/ 1.5 .f)",      CCExpressionValueTypeFloat,     .real = 1.5 / f },
        { "(/ -1.5 .f)",     CCExpressionValueTypeFloat,     .real = -1.5 / f },
        
        { "(/ 1 2.5)",      CCExpressionValueTypeFloat,     .real = 1 / 2.5 },
        { "(/ 1.5 2)",      CCExpressionValueTypeFloat,     .real = 1.5 / 2 },
        { "(/ -1 2.5)",     CCExpressionValueTypeFloat,     .real = -1 / 2.5 },
        { "(/ -1.5 2)",     CCExpressionValueTypeFloat,     .real = -1.5 / 2 },
        { "(/ 1 -2.5)",     CCExpressionValueTypeFloat,     .real = 1 / -2.5 },
        { "(/ 1.5 -2)",     CCExpressionValueTypeFloat,     .real = 1.5 / -2 },
        { "(/ -1 -2.5)",    CCExpressionValueTypeFloat,     .real = -1 / -2.5 },
        { "(/ -1.5 -2)",    CCExpressionValueTypeFloat,     .real = -1.5 / -2 },
        { "(/ 1 .f)",        CCExpressionValueTypeFloat,     .real = 1 / f },
        { "(/ 1.5 .i)",      CCExpressionValueTypeFloat,     .real = 1.5 / i },
        
        { "(/ .test 1)",     CCExpressionValueTypeExpression },
        { "(/ \"s\" 1)",    CCExpressionValueTypeExpression },
        { "(/ () 1)",       CCExpressionValueTypeExpression },
        { "(/ 1 .test)",     CCExpressionValueTypeExpression },
        { "(/ 1 \"s\")",    CCExpressionValueTypeExpression },
        { "(/ 1 ())",       CCExpressionValueTypeExpression },
        { "(/ .test 1.0)",   CCExpressionValueTypeExpression },
        { "(/ \"s\" 1.0)",  CCExpressionValueTypeExpression },
        { "(/ () 1.0)",     CCExpressionValueTypeExpression },
        { "(/ 1.0 .test)",   CCExpressionValueTypeExpression },
        { "(/ 1.0 \"s\")",  CCExpressionValueTypeExpression },
        { "(/ 1.0 ())",     CCExpressionValueTypeExpression },
        
        { "(/ 1 2 9)",      CCExpressionValueTypeInteger,   .integer = 1 / 2 / 9 },
        { "(/ 1 -2 9)",     CCExpressionValueTypeInteger,   .integer = 1 / -2 / 9 },
        { "(/ -1 2 9)",     CCExpressionValueTypeInteger,   .integer = -1 / 2 / 9 },
        { "(/ -1 -2 9)",    CCExpressionValueTypeInteger,   .integer = -1 / -2 / 9 },
        { "(/ 1 .i 9)",      CCExpressionValueTypeInteger,   .integer = 1 / i / 9 },
        { "(/ -1 .i 9)",     CCExpressionValueTypeInteger,   .integer = -1 / i / 9 },
        { "(/ 1.5 2.5 9)",  CCExpressionValueTypeFloat,     .real = 1.5 / 2.5 / 9 },
        { "(/ 1.5 -2.5 9)", CCExpressionValueTypeFloat,     .real = 1.5 / -2.5 / 9 },
        { "(/ -1.5 2.5 9)", CCExpressionValueTypeFloat,     .real = -1.5 / 2.5 / 9 },
        { "(/ -1.5 -2.5 9)",CCExpressionValueTypeFloat,     .real = -1.5 / -2.5 / 9 },
        { "(/ 1.5 .f 9)",    CCExpressionValueTypeFloat,     .real = 1.5 / f / 9 },
        { "(/ -1.5 .f 9)",   CCExpressionValueTypeFloat,     .real = -1.5 / f / 9 },
        
        { "(/ (/ 1 2) (/ 9 5))",    CCExpressionValueTypeInteger, .integer = (1 / 2) / (9 / 5) },
        { "(/ (/ 1.0 2) (/ 9 5))",  CCExpressionValueTypeFloat,   .real = (1.0f / 2) / (9 / 5) },
        { "(/ (/ 1 2) (/ 9.0 5))",  CCExpressionValueTypeFloat,   .real = (1 / 2) / (9.0f / 5) },
        { "(/ (/ .test 2) (/ 9 5))", CCExpressionValueTypeExpression }
    };
    
    
    [self assert: Test count: sizeof(Test) / sizeof(*Test)];
}

-(void) testMinima
{
    ExpressionResult Test[] = {
        { "(min)",            CCExpressionValueTypeExpression },
        { "(min 1)",          CCExpressionValueTypeInteger,   .integer = 1 },
        { "(min -1)",         CCExpressionValueTypeInteger,   .integer = -1 },
        { "(min 1.5)",        CCExpressionValueTypeFloat,     .real = 1.5f },
        { "(min -1.5)",       CCExpressionValueTypeFloat,     .real = -1.5f },
        { "(min .test)",       CCExpressionValueTypeExpression },
        { "(min .i)",          CCExpressionValueTypeInteger,   .integer = -5 },
        { "(min .f)",          CCExpressionValueTypeFloat,     .real = -2.5f },
        { "(min \"string\")", CCExpressionValueTypeExpression },
        { "(min ())",         CCExpressionValueTypeExpression },
        
        { "(min 1 2)",        CCExpressionValueTypeInteger,   .integer = MIN(1, 2) },
        { "(min 1 -2)",       CCExpressionValueTypeInteger,   .integer = MIN(1, -2) },
        { "(min -1 2)",       CCExpressionValueTypeInteger,   .integer = MIN(-1, 2) },
        { "(min -1 -2)",      CCExpressionValueTypeInteger,   .integer = MIN(-1, -2) },
        { "(min 1 .i)",        CCExpressionValueTypeInteger,   .integer = MIN(1, i) },
        { "(min -1 .i)",       CCExpressionValueTypeInteger,   .integer = MIN(-1, i) },
        { "(min 1.5 2.5)",    CCExpressionValueTypeFloat,     .real = MIN(1.5, 2.5) },
        { "(min 1.5 -2.5)",   CCExpressionValueTypeFloat,     .real = MIN(1.5, -2.5) },
        { "(min -1.5 2.5)",   CCExpressionValueTypeFloat,     .real = MIN(-1.5, 2.5) },
        { "(min -1.5 -2.5)",  CCExpressionValueTypeFloat,     .real = MIN(-1.5, -2.5) },
        { "(min 1.5 .f)",      CCExpressionValueTypeFloat,     .real = MIN(1.5, f) },
        { "(min -1.5 .f)",     CCExpressionValueTypeFloat,     .real = MIN(-1.5, f) },
        
        { "(min 1 2.5)",      CCExpressionValueTypeFloat,     .real = MIN(1, 2.5) },
        { "(min 1.5 2)",      CCExpressionValueTypeFloat,     .real = MIN(1.5, 2) },
        { "(min -1 2.5)",     CCExpressionValueTypeFloat,     .real = MIN(-1, 2.5) },
        { "(min -1.5 2)",     CCExpressionValueTypeFloat,     .real = MIN(-1.5, 2) },
        { "(min 1 -2.5)",     CCExpressionValueTypeFloat,     .real = MIN(1, -2.5) },
        { "(min 1.5 -2)",     CCExpressionValueTypeFloat,     .real = MIN(1.5, -2) },
        { "(min -1 -2.5)",    CCExpressionValueTypeFloat,     .real = MIN(-1, -2.5) },
        { "(min -1.5 -2)",    CCExpressionValueTypeFloat,     .real = MIN(-1.5, -2) },
        { "(min 1 .f)",        CCExpressionValueTypeFloat,     .real = MIN(1, f) },
        { "(min 1.5 .i)",      CCExpressionValueTypeFloat,     .real = MIN(1.5, i) },
        
        { "(min .test 1)",     CCExpressionValueTypeExpression },
        { "(min \"s\" 1)",    CCExpressionValueTypeExpression },
        { "(min () 1)",       CCExpressionValueTypeExpression },
        { "(min 1 .test)",     CCExpressionValueTypeExpression },
        { "(min 1 \"s\")",    CCExpressionValueTypeExpression },
        { "(min 1 ())",       CCExpressionValueTypeExpression },
        { "(min .test 1.0)",   CCExpressionValueTypeExpression },
        { "(min \"s\" 1.0)",  CCExpressionValueTypeExpression },
        { "(min () 1.0)",     CCExpressionValueTypeExpression },
        { "(min 1.0 .test)",   CCExpressionValueTypeExpression },
        { "(min 1.0 \"s\")",  CCExpressionValueTypeExpression },
        { "(min 1.0 ())",     CCExpressionValueTypeExpression },
        
        { "(min 1 2 9)",      CCExpressionValueTypeInteger,   .integer = MIN(MIN(1, 2), 9) },
        { "(min 1 -2 9)",     CCExpressionValueTypeInteger,   .integer = MIN(MIN(1, -2), 9) },
        { "(min -1 2 9)",     CCExpressionValueTypeInteger,   .integer = MIN(MIN(-1, 2), 9) },
        { "(min -1 -2 9)",    CCExpressionValueTypeInteger,   .integer = MIN(MIN(-1, -2), 9) },
        { "(min 1 .i 9)",      CCExpressionValueTypeInteger,   .integer = MIN(MIN(1, i), 9) },
        { "(min -1 .i 9)",     CCExpressionValueTypeInteger,   .integer = MIN(MIN(-1, i), 9) },
        { "(min 1.5 2.5 9)",  CCExpressionValueTypeFloat,     .real = MIN(MIN(1.5, 2.5), 9) },
        { "(min 1.5 -2.5 9)", CCExpressionValueTypeFloat,     .real = MIN(MIN(1.5, -2.5), 9) },
        { "(min -1.5 2.5 9)", CCExpressionValueTypeFloat,     .real = MIN(MIN(-1.5, 2.5), 9) },
        { "(min -1.5 -2.5 9)",CCExpressionValueTypeFloat,     .real = MIN(MIN(-1.5, -2.5), 9) },
        { "(min 1.5 .f 9)",    CCExpressionValueTypeFloat,     .real = MIN(MIN(1.5, f), 9) },
        { "(min -1.5 .f 9)",   CCExpressionValueTypeFloat,     .real = MIN(MIN(-1.5, f), 9) },
        
        { "(min (min 1 2) (min 9 5))",    CCExpressionValueTypeInteger, .integer = MIN(MIN(1, 2), MIN(9, 5)) },
        { "(min (min 1.0 2) (min 9 5))",  CCExpressionValueTypeFloat,   .real = MIN(MIN(1.0f, 2), MIN(9, 5)) },
        { "(min (min 1 2) (min 9.0 5))",  CCExpressionValueTypeFloat,   .real = MIN(MIN(1, 2), MIN(9.0f, 5)) },
        { "(min (min .test 2) (min 9 5))", CCExpressionValueTypeExpression }
    };
    
    
    [self assert: Test count: sizeof(Test) / sizeof(*Test)];
}

-(void) testMaxima
{
    ExpressionResult Test[] = {
        { "(max)",            CCExpressionValueTypeExpression },
        { "(max 1)",          CCExpressionValueTypeInteger,   .integer = 1 },
        { "(max -1)",         CCExpressionValueTypeInteger,   .integer = -1 },
        { "(max 1.5)",        CCExpressionValueTypeFloat,     .real = 1.5f },
        { "(max -1.5)",       CCExpressionValueTypeFloat,     .real = -1.5f },
        { "(max .test)",       CCExpressionValueTypeExpression },
        { "(max .i)",          CCExpressionValueTypeInteger,   .integer = -5 },
        { "(max .f)",          CCExpressionValueTypeFloat,     .real = -2.5f },
        { "(max \"string\")", CCExpressionValueTypeExpression },
        { "(max ())",         CCExpressionValueTypeExpression },
        
        { "(max 1 2)",        CCExpressionValueTypeInteger,   .integer = MAX(1, 2) },
        { "(max 1 -2)",       CCExpressionValueTypeInteger,   .integer = MAX(1, -2) },
        { "(max -1 2)",       CCExpressionValueTypeInteger,   .integer = MAX(-1, 2) },
        { "(max -1 -2)",      CCExpressionValueTypeInteger,   .integer = MAX(-1, -2) },
        { "(max 1 .i)",        CCExpressionValueTypeInteger,   .integer = MAX(1, i) },
        { "(max -1 .i)",       CCExpressionValueTypeInteger,   .integer = MAX(-1, i) },
        { "(max 1.5 2.5)",    CCExpressionValueTypeFloat,     .real = MAX(1.5, 2.5) },
        { "(max 1.5 -2.5)",   CCExpressionValueTypeFloat,     .real = MAX(1.5, -2.5) },
        { "(max -1.5 2.5)",   CCExpressionValueTypeFloat,     .real = MAX(-1.5, 2.5) },
        { "(max -1.5 -2.5)",  CCExpressionValueTypeFloat,     .real = MAX(-1.5, -2.5) },
        { "(max 1.5 .f)",      CCExpressionValueTypeFloat,     .real = MAX(1.5, f) },
        { "(max -1.5 .f)",     CCExpressionValueTypeFloat,     .real = MAX(-1.5, f) },
        
        { "(max 1 2.5)",      CCExpressionValueTypeFloat,     .real = MAX(1, 2.5) },
        { "(max 1.5 2)",      CCExpressionValueTypeFloat,     .real = MAX(1.5, 2) },
        { "(max -1 2.5)",     CCExpressionValueTypeFloat,     .real = MAX(-1, 2.5) },
        { "(max -1.5 2)",     CCExpressionValueTypeFloat,     .real = MAX(-1.5, 2) },
        { "(max 1 -2.5)",     CCExpressionValueTypeFloat,     .real = MAX(1, -2.5) },
        { "(max 1.5 -2)",     CCExpressionValueTypeFloat,     .real = MAX(1.5, -2) },
        { "(max -1 -2.5)",    CCExpressionValueTypeFloat,     .real = MAX(-1, -2.5) },
        { "(max -1.5 -2)",    CCExpressionValueTypeFloat,     .real = MAX(-1.5, -2) },
        { "(max 1 .f)",        CCExpressionValueTypeFloat,     .real = MAX(1, f) },
        { "(max 1.5 .i)",      CCExpressionValueTypeFloat,     .real = MAX(1.5, i) },
        
        { "(max .test 1)",     CCExpressionValueTypeExpression },
        { "(max \"s\" 1)",    CCExpressionValueTypeExpression },
        { "(max () 1)",       CCExpressionValueTypeExpression },
        { "(max 1 .test)",     CCExpressionValueTypeExpression },
        { "(max 1 \"s\")",    CCExpressionValueTypeExpression },
        { "(max 1 ())",       CCExpressionValueTypeExpression },
        { "(max .test 1.0)",   CCExpressionValueTypeExpression },
        { "(max \"s\" 1.0)",  CCExpressionValueTypeExpression },
        { "(max () 1.0)",     CCExpressionValueTypeExpression },
        { "(max 1.0 .test)",   CCExpressionValueTypeExpression },
        { "(max 1.0 \"s\")",  CCExpressionValueTypeExpression },
        { "(max 1.0 ())",     CCExpressionValueTypeExpression },
        
        { "(max 1 2 9)",      CCExpressionValueTypeInteger,   .integer = MAX(MAX(1, 2), 9) },
        { "(max 1 -2 9)",     CCExpressionValueTypeInteger,   .integer = MAX(MAX(1, -2), 9) },
        { "(max -1 2 9)",     CCExpressionValueTypeInteger,   .integer = MAX(MAX(-1, 2), 9) },
        { "(max -1 -2 9)",    CCExpressionValueTypeInteger,   .integer = MAX(MAX(-1, -2), 9) },
        { "(max 1 .i 9)",      CCExpressionValueTypeInteger,   .integer = MAX(MAX(1, i), 9) },
        { "(max -1 .i 9)",     CCExpressionValueTypeInteger,   .integer = MAX(MAX(-1, i), 9) },
        { "(max 1.5 2.5 9)",  CCExpressionValueTypeFloat,     .real = MAX(MAX(1.5, 2.5), 9) },
        { "(max 1.5 -2.5 9)", CCExpressionValueTypeFloat,     .real = MAX(MAX(1.5, -2.5), 9) },
        { "(max -1.5 2.5 9)", CCExpressionValueTypeFloat,     .real = MAX(MAX(-1.5, 2.5), 9) },
        { "(max -1.5 -2.5 9)",CCExpressionValueTypeFloat,     .real = MAX(MAX(-1.5, -2.5), 9) },
        { "(max 1.5 .f 9)",    CCExpressionValueTypeFloat,     .real = MAX(MAX(1.5, f), 9) },
        { "(max -1.5 .f 9)",   CCExpressionValueTypeFloat,     .real = MAX(MAX(-1.5, f), 9) },
        
        { "(max (max 1 2) (max 9 5))",    CCExpressionValueTypeInteger, .integer = MAX(MAX(1, 2), MAX(9, 5)) },
        { "(max (max 1.0 2) (max 9 5))",  CCExpressionValueTypeFloat,   .real = MAX(MAX(1.0f, 2), MAX(9, 5)) },
        { "(max (max 1 2) (max 9.0 5))",  CCExpressionValueTypeFloat,   .real = MAX(MAX(1, 2), MAX(9.0f, 5)) },
        { "(max (max .test 2) (max 9 5))", CCExpressionValueTypeExpression }
    };
    
    
    [self assert: Test count: sizeof(Test) / sizeof(*Test)];
}

@end