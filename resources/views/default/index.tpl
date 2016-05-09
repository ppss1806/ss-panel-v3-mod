{include file='header.tpl'}
<div class="section no-pad-bot" id="index-banner">
    <div class="container">
        <br><br>
        <h1 class="header center green-text">{$config["appName"]}</h1>
        <div class="row center">
            <h5 class="header col s12 light">通向远方</h5>
        </div>
        {if $user->isLogin}
            <div class="row center">
                <a href="/user" id="download-button" class="btn-large waves-effect waves-light green">进入用户中心</a>
            </div>
        {else}
        <div class="row center">
            <a href="/auth/register" id="download-button" class="btn-large waves-effect waves-light green">立即注册</a>
        </div>
        {/if}
        <br><br>
    </div>
</div>


{include file='footer.tpl'}