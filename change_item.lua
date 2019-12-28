--- 2つのアイテムを取得
local off_item = vci.assets.GetSubItem("off_item")
local on_item = vci.assets.GetSubItem("on_item")
--- 握っている時にonUseが使えないようにフラグ
local is_grab = false
--- on_offのフラグ
local item_status = 0;

--- init
--- on状態のアイテムを隠す
on_item.SetLocalPosition(Vector3.__new(0,-100,0))

---[SubItemの所有権&Use状態]アイテムをグラッブしてグリップボタンを押すと呼ばれる。
---@param use string @押されたアイテムのSubItem名
function onUse(use)
    if is_grab == false then
        if item_status == 0 then
            ---アイテムをオンにする
            item_status = 1

            ---offオブジェを隠す
            off_item.SetLocalPosition(Vector3.__new(0,-100,0))

            ---今いる場所にオンオブジェを移動させる
            local now_item_position = off_item.GetLocalPosition()
            local now_item_rotation = off_item.GetLocalRotation()
            on_item.SetLocalPosition(now_item_position)
            on_item.SetLocalRotation(now_item_rotation)

            ---回転と速度を0にする
            on_item.SetVelocity(Vector3.zero)
            on_item.SetAngularVelocity(Vector3.zero)

        else
            -- アイテムをオフにする
            item_status = 0

            ---onオブジェを隠す
            on_item.SetLocalPosition(Vector3.__new(0,-100,0))

            ---今いる場所にオンオブジェを移動させる
            local now_item_position = on_item.GetLocalPosition()
            local now_item_rotation = on_item.GetLocalRotation()
            off_item.SetLocalPosition(now_item_position)
            off_item.SetLocalRotation(now_item_rotation)

            ---回転と速度を0にする
            off_item.SetVelocity(Vector3.zero)
            off_item.SetAngularVelocity(Vector3.zero)
        end
    end
end

---[SubItemの所有権&Grab状態]アイテムをGrabしたときに呼ばれる。
---@param target string @GrabされたSubItem名
function onGrab(target)
    is_grab = true
end

---[not SubItemの所有権&Grab状態]アイテムをUngrabしたときに呼ばれる。
---@param target string @UngrabされたSubItem名
function onUngrab(target)
    is_grab = false
end