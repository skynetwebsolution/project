<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>EziAssist</title>
{include file='location_includes/script.tpl'}
<link href="{$css_path}bootstrap.css" rel="stylesheet" type="text/css" />
<link href="{$css_path}main.css" rel="stylesheet" type="text/css" />
<link href="{$css_path}custom.css" rel="stylesheet" type="text/css" />
<link href="{$css_path}fileuploader.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" media="screen" href="{$css_path}bootstrap-datetimepicker.min.css" />

<script src="{$js_path}jquery.min.js" type="text/javascript"></script>
<script src="{$js_path}winfix.js" type="text/javascript"></script>
<script type="text/javascript" src="{$js_path}fileuploader.js"></script>
<script type="text/javascript" src="{$SITE_PATH}ckeditor/ckeditor.js"></script>
</head>
<!--<div id="fb-root"></div>
{literal}
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.0";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
{/literal}
<div id="fb-root"></div>
{literal}
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.0";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
{/literal}-->
<body>
{include file='location_includes/header.tpl'}
{include file='location_includes/banner.tpl'}
{include file='location_includes/nav.tpl'}
<!--body-->
<div class="container">
  <div class="row">
    <div class="col-md-8">
      <h1>Post News</h1>
      <div class="row regForm">
        <div class="col-md-12">
          <div id="disp_boardproerr" class="alert alert-danger" style="display:none;"></div>
          <div id="disp_boardprosuc" class="alert alert-success" style="display:none;"></div>
          <form class="form-horizontal" role="form" name="frm_news_create" id="frm_news_create">
            <div class="form-group">
            {if isset($LOGGEDIN_USER)}
              <label for="inputPassword3" class="col-sm-3 control-label">Email<span class="text-danger">*</span></label>
              <div class="col-sm-9">
               <input type="text" class="form-control"  value="{$LOGGEDIN_USER['UserEmail']}" readonly name="NewsEmail" id="NewsEmail">
              </div>
             {else if $newsArr['NewsEmail'] ne ''}
              <label for="inputPassword3" class="col-sm-3 control-label">Email<span class="text-danger">*</span></label>
              <div class="col-sm-9">
               <input type="text" class="form-control"  value="{$newsArr['NewsEmail']}" readonly name="NewsEmail" id="NewsEmail">
              </div>
             {else}
              <label for="inputPassword3" class="col-sm-3 control-label">Email<span class="text-danger">*</span></label>
              <div class="col-sm-9">
                <div class="input-group">
                  <input type="text" class="form-control"  value="{if $newsArr['NewsEmail'] ne ''}{$newsArr['NewsEmail']}{else}Email{/if}" name="NewsEmail" id="NewsEmail">
                  <span class="input-group-btn">
                  <button class="btn btn-default emailGo" type="button" id="checkuser">Go</button>
                  </span> </div>
              </div>
             {/if} 
            </div>
            <div class="form-group" id="usercheck_loading"  style="display:none">
              <div class="col-sm-9 col-sm-offset-3">
                <p class="text-center" id="loader_img"><img src="{$images_path}fancybox_loading.gif" alt=""></p>
                  <div class=" col-sm-12 ">
                    <p class="text-left" id="loader_msg"></p>
                    <button type="button" class="btn btn-danger btnlessgap fullWidth2" style="cursor:pointer;" id="login" data-toggle="modal" data-target="#loginModal">Log in</button>
                    <button type="button" class="btn btn-danger btnlessgap fullWidth2" id="btnregister">Sign up</button>
                    <button type="button" class="btn btn-danger pull-right fullWidth2" id="req-continue">Continue</button>
                  </div>
              </div>
            </div>
            <div id="create_news" {if !(isset($LOGGEDIN_USER)) && $newsArr['NewsEmail'] eq ''} style="display:none" {/if}>
                <div class="form-group">
                  <label for="inputPassword3" class="col-sm-3 control-label">Contact Person<span class="text-danger">*</span></label>
                  <div class="col-sm-9">
                    <input type="text" class="form-control" value="{if $newsArr['NewsContact'] ne ''}{$newsArr['NewsContact']}{else}Contact Person{/if}" name="NewsContact" id="NewsContact">
                  </div>
                </div>
                <div class="form-group">
                  <label for="inputPassword3" class="col-sm-3 control-label">Contact No.<span class="text-danger">*</span></label>
                  <div class="col-sm-9">
                    <input type="text" class="form-control" value="{if $newsArr['NewsContactNumber'] ne ''}{$newsArr['NewsContactNumber']}{else}Contact No.{/if}" name="NewsContactNumber" id="NewsContactNumber">
                  </div>
                </div>
                <div class="form-group">
                  <label for="inputPassword3" class="col-sm-3 control-label">Title<span class="text-danger">*</span></label>
                  <div class="col-sm-9">
                    <input type="text" class="form-control" value="{if $newsArr['NewsTitle'] ne ''}{$newsArr['NewsTitle']}{else}Title{/if}" name="NewsTitle" id="NewsTitle">
                  </div>
                </div>
                <div class="form-group">
                  <label for="inputPassword3" class="col-sm-3 control-label">Category<span class="text-danger">*</span></label>
                  <div class="col-sm-9">
                    <select class="form-control" name="NewsCategory" id="NewsCategory">
                    <option value="0">Select Category</option>
                    {foreach from=$categoryArray['CategoryId'] key=k item=v}
                      <option value="{$v}" {if $newsArr['NewsCategory'] eq $v} selected {/if}>{$categoryArray['CategoryTitle'][$k]}</option>
                    {/foreach}
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label for="inputPassword3" class="col-sm-3 control-label">Location<span class="text-danger">*</span></label>
                  <div class="col-sm-9">
                    <select class="form-control" name="NewsLocation" id="NewsLocation">
                    <option value="0">Select Location</option>
                    {foreach from=$locationlist key=k item=v}
                      <option value="{$k}" {if $RegisteredLocationId eq $k} selected="selected" {/if} {if $newsArr['NewsLocation'] eq $k} selected {/if}>{$v}</option>
                    {/foreach}
                    </select>
                  </div>
                </div>
                <div id="otherLocation">
                    <div class="form-group">
                      <label for="inputPassword3" class="col-sm-3 control-label">Location Name<span class="text-danger">*</span></label>
                      <div class="col-sm-9">
                        <input type="text" class="form-control" value="{if $newsArr['OtherLocationName'] ne ''}{$newsArr['OtherLocationName']}{else}Location Name{/if}" name="OtherLocationName" id="OtherLocationName">
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputPassword3" class="col-sm-3 control-label">Location Pincode<span class="text-danger">*</span></label>
                      <div class="col-sm-9">
                        <input type="text" class="form-control" value="{if $newsArr['OtherLocationPincode'] ne ''}{$newsArr['OtherLocationPincode']}{else}Location Pincode{/if}" name="OtherLocationPincode" id="OtherLocationPincode">
                      </div>
                    </div>
                </div>
                <div class="form-group">
                  <label for="inputPassword3" class="col-sm-3 control-label">Description<span class="text-danger">*</span></label>
                  <div class="col-sm-9"> 
                    <textarea name="NewsDescription" id="NewsDescription">{if $newsArr['NewsDescription'] ne ''}{$newsArr['NewsDescription']}{/if}</textarea>
                    <script type="text/javascript"> 
                        CKEDITOR.replace( 'NewsDescription', 
                         { 
                            toolbar:'Basic' 
                        }); 
                    </script>
                  </div>
                </div>
                <div class="form-group">
                  <label for="inputPassword3" class="col-sm-3 control-label">Map Location<span class="text-danger">*</span></label>
                  <div class="col-sm-9">
                    <select class="form-control" name="NewsMapLocation" id="NewsMapLocation">
                      <option value="0">Select Location</option>
                      {assign var=maparr value=","|explode:$newsArr['NewsMapLocation']}
                       {foreach from=$locationlist key=k item=v}
                         {if $k ne 21}
                          <option value="{$k}" {if $k|in_array:$maparr} selected="selected" {/if}>{$v}</option>
                         {/if} 
                       {/foreach}
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <div class="col-xs-12">
                    <p class="text-right fontsize11px">[ Your News will get published at the selected <b>one</b> location ]</p>
                  </div>
                </div>
                <!--<div class="form-group">
                  <label for="inputPassword3" class="col-sm-3 control-label">From Date<span class="text-danger">*</span></label>
                  <div class="col-sm-3">
                    <div class='input-group date' id='datetimepicker1'>
                      <input type='text' class="form-control" name="NewsStartDate" id="NewsStartDate" value="{if $newsArr['NewsStartDate'] ne ''}{$newsArr['NewsStartDate']}{/if}" />
                      <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span> </span> </div>
                      <script type="text/javascript">
                      $(function() {
                        $('#datetimepicker1').datetimepicker({
                          pickTime: false
                        });
                      });
                    </script>
                  </div>
                  <label for="inputPassword3" class="col-sm-3 control-label">To Date<span class="text-danger">*</span></label>
                  <div class="col-sm-3">
                    <div class='input-group date' id='datetimepicker2'>
                      <input type='text' class="form-control" name="NewsEndDate" id="NewsEndDate" value="{if $newsArr['NewsEndDate'] ne ''}{$newsArr['NewsEndDate']}{/if}" />
                      <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span> </span> </div>
                    <script type="text/javascript">
                      $(function() {
                        $('#datetimepicker2').datetimepicker({
                          pickTime: false
                        });
                      });
                    </script>
                  </div>
                </div>-->
                <div class="form-group">
                  <label for="inputPassword3" class="col-sm-3 control-label">News Image</label>
                  <div class="col-sm-9">
                    <a href="#nowhere" class="btn btn-danger btnGapziro fullWidth2" id="ImageUpload" >Upload</a> </div>
                </div>
                <div class="form-group">
                  <div class="col-sm-offset-3 col-sm-9 text-right" id="uploadimglist">
                  
                  <div id="uploadgallery">
                  {if $imagelist['Id'][0] ne ''} 
                      {section name=data loop=$imagelist['Id']}
                        <div class="uploadImgText">
                         <div class="uploadImg"><a href="#"  data-toggle="modal" data-target="#bigimg" id="uploadedimg-{$imagelist['Id'][data]}"><img src="{$imagelist['Image'][data]}" title="{$imagelist['ImageTitle'][data]}"></a>
                          <!--<a href="#"><img src="{$images_path}close.png" alt="" class="uploadImgClose" id="deleteimg-{$imagelist['Id'][data]}"></a>-->
                          <a class="pull-left mousepointer"><img title="Delete" id="deleteimg-{$imagelist['Id'][data]}" src="{$images_path}delete.png" alt="" ></a>
                          <a class="pull-right mousepointer"><img title="Edit" id="editimg-{$imagelist['Id'][data]}|{$imagelist['ImageTitle'][data]}|{$imagelist['ImageDescription'][data]}|{$imagelist['Image'][data]}|{$imagelist['CaptureDate'][data]}|{$newsArr['EntityId']}|{$imagelist['ImageFile'][data]}" src="{$images_path}imgedit.png" alt="" ></a>
                         </div>
                         <!--<p id="uploadedtxt-{$imagelist['Id'][data]}">{$imagelist['ImageTitle'][data]}</p>-->
                        </div>
                      {/section}  
                  {/if}
                  </div>
                  
                    
                  </div>
                </div>
                <div class="form-group">
                  <div class="col-xs-12">
                    <p class="text-right fontsize11px" id="uploadtextlimit">[ To upload more images of the news, please Log in/Sign up ]</p>
                  </div>
                </div>
                <div class="form-group">
                  <div class="col-sm-offset-3 col-sm-9">
                    <input type="hidden" name="UserId" id="UserId" value="{if isset($LOGGEDIN_USER)}{$LOGGEDIN_USER['UserId']}{else}{if $newsArr['UserId'] ne ''}{$newsArr['UserId']}{/if}{/if}">
                    <input type="hidden" name="NewsStartDate" id="NewsStartDate" value="{if isset($newsArr)}{$newsArr['NewsStartDate']}{/if}"
                    <input type="hidden" name="Id" id="Id" value="{if isset($newsArr)}{$newsArr['Id']}{/if}">
                    <input type="hidden" name="EntityId" id="EntityId" value="{if isset($newsArr)}{$newsArr['EntityId']}{/if}">
                    {if isset($newsArr['edit'])}
                    	<input type="hidden" name="Status" id="Status" value="0">
                      {if $newsArr['Submited']==0 }
                      <button type="button" class="btn btn-danger btnlessgap fullWidth2" id="saveas-draft">Save Draft</button>
                      {/if}
                      <button type="button" class="btn btn-danger pull-right fullWidth2" id="saveas-submit">Submit</button>
                    {else}
                      <button type="button" class="btn btn-danger btnlessgap fullWidth2" id="saveas-draft">Save Draft</button>
                      <button type="button" class="btn btn-danger pull-right fullWidth2" id="saveas-submit">Submit</button>
                    {/if}
                    
                  </div>
                </div>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="row fiveResons">
        <div class="col-md-12">
          <h1>Reasons to post news</h1>
        </div>
        <div class="col-md-12">
          <div class="media"> <img class="media-object pull-left" src="{$images_path}regintration-meadia1.png" alt="...">
            <div class="media-body">
              <h4 class="media-heading">1. Curabitur augue sem</h4>
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam congue vulputate neque.</p>
            </div>
          </div>
          <div class="media mediaColor"> <img class="media-object pull-left" src="{$images_path}regintration-meadia2.png" alt="...">
            <div class="media-body">
              <h4 class="media-heading">2. Donec vulputate augue</h4>
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam congue vulputate neque.</p>
            </div>
          </div>
          <div class="media"> <img class="media-object pull-left" src="{$images_path}regintration-meadia3.png" alt="...">
            <div class="media-body">
              <h4 class="media-heading">3. Curabitur augue dignissim</h4>
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam congue vulputate neque.</p>
            </div>
          </div>
          <div class="media mediaColor"> <img class="media-object pull-left" src="{$images_path}regintration-meadia4.png" alt="...">
            <div class="media-body">
              <h4 class="media-heading">4. Quisque commodo elit</h4>
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam congue vulputate neque.</p>
            </div>
          </div>
          <div class="media"> <img class="media-object pull-left" src="{$images_path}regintration-meadia5.png" alt="...">
            <div class="media-body">
              <h4 class="media-heading">5. Sed suscipit auctor quam</h4>
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam congue vulputate neque.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!--body end-->
<!--footer-->
{include file='location_includes/footer.tpl'}
<!--footer end-->

<!-- Modal section -->
{include file='modal/location_modal.tpl'}

{include file='location_includes/modals/imageupload.tpl'}
{include file='location_includes/modals/image.tpl'}
<!-- Modal section -->

{literal}
<script type="text/javascript">
var SITE_PATH = {/literal}'{$SITE_PATH}'{literal};
var ADMIN_PATH = {/literal}'{$ADMIN_PATH}'{literal};
var ADMIN_URL = {/literal}'{$ADMIN_URL}'{literal};
var RegisteredLocationId = {/literal}'{$RegisteredLocationId}'{literal};
var LoggedUserId = parseInt({/literal}{if isset($LOGGEDIN_USER)}{$LOGGEDIN_USER['UserId']}{else}0{/if}{literal});
</script>
{/literal}

<script src="{$js_path}functions.custom.js" type="text/javascript"></script>
<script src="{$js_path}general.jquery.js" type="text/javascript"></script>
<script src="{$js_path}jquery.custom.news.js" type="text/javascript"></script>
<script src="{$js_path}bootstrap.js" type="text/javascript"></script>
{literal}
<script>
$('#element1').popover('hide')
$('#element2').popover('hide')
$('#element3').popover('hide')
$('#element4').popover('hide')
</script>
<script>
$('#pdffile').change(function(){
$('#subfile').val($(this).val());
}); 
$('#pdffile2').change(function(){
$('#subfile2').val($(this).val());
}); 
$('#pdffile3').change(function(){
$('#subfile3').val($(this).val());
}); 
</script>
{/literal}
<script type="text/javascript" src="{$js_path}moment-2.4.0.js"></script>
<script type="text/javascript" src="{$js_path}bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="{$js_path}bootstrap-datetimepicker.ru.js"></script>
{literal}
<script>
	$(function(){
		var $window = $(window), $body   = $(document.body);
		$body.scrollspy({
			target: '.bs-sidebar'
		});
	});
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','../../www.google-analytics.com/analytics.js','ga');
	
	ga('create', 'UA-47462200-1', 'eonasdan.github.io');
	ga('send', 'pageview');
</script>
{/literal}
<script src="{$js_path}placeholder.js" type="text/javascript"></script>

{include file='modal/locationfb_modal.tpl'}
{include file='modal/login_modal.tpl'}
</body>
</html>
