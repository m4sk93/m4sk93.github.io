+++
title = 'JustCTF2024'
date = 2024-06-19T00:44:30Z
+++


https://2024.justctf.team/challenges
有三道blockchain题目，都是sui move的,

这些题目使用[sui-ctf-framework](https://github.com/otter-sec/sui-ctf-framework/tree/justctf2024)进行部署，我觉得还挺有意思的.

以tos_docker.tar.gz这道签到题为例，分析下出题框架.

## 调用solve



https://github.com/m4sk93/movectf/blob/b73a9ca26fd44b00e00eeca837ea2b481bf35c45/justctf2024/tos/sources/framework/src/main.rs#L162-L187

准备参数时，需要获取一些ObjectID
```
    // Prepare Function Call Arguments
    let mut args_solve: Vec<SuiValue> = Vec::new();
    let spellbook = SuiValue::Object(FakeID::Enumerated(2, 0), None); 
    args_solve.push(spellbook.clone());

    let type_args_solve: Vec<TypeTag> = Vec::new();

    // Call solve Function
    let ret_val = match sui_ctf_framework::call_function(
        &mut adapter,
        sol_addr,
        "solve",
        "solve",
        args_solve,
        type_args_solve,
        Some("solver".to_string()),
    ).await {
        Ok(output) => output,
        Err(e) => {
            let _ = adapter.cleanup_resources().await;
            println!("[SERVER] error: {e}");
            return Err("error during call to solve::solve".into())
        }
    };
    println!("[SERVER] Return value {:#?}", ret_val);
    println!("");
```
