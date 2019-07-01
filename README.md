# Flutter_Bloc

Bloc 实战，在RxDart和Stream的基础上结合实际业务场景，对Bloc的应用进行探索和实践；
本次除了大家比较熟悉的Provider的设计之外还增加了State和Event两个概念。State代表
某一时刻数据的状态，有些复杂的业务场景可能会有很多个状态，这些业务逻辑依据某一特定的
流程来执行，在这一整个流程中可能同一个State会改变多次；所以基于这样的复杂的业务场景
就引出了一个Event的概念，Event就代表这一个完成流程执行的控制单元，我们把它称作“事件”，
真个执行流程由事件驱动，根据具体的Event来改变State，最终的State大多数情况下直接影响
UI的变化。

## Event

## State

## Bloc

## BlocBuilder

