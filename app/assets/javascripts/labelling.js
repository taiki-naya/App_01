$(document).on('turbolinks:load', function() {

  var leagueVal = $('#label_league').val();
  var teamVal = $('#label_team').val();

  if (leagueVal !== "") {
    var selectedTemplateOfTeam = $("#teams-of-league_" + leagueVal);
    var selectedTemplateOfKit = $("#kits-of-team_" + teamVal);
    $('#label_team').remove();
    $('#label_league').after(selectedTemplateOfTeam.html());
    $('#label_kit').remove();
    $('#label_team').after(selectedTemplateOfKit.html());
  };

  var defaultTeamSelect = '<select name=\"label[team]\" id=\"label_team\"><option value=\"\">チームを選択してください</option></select>';
  var defaultKitSelect = '<select name=\"label[kit]\" id=\"label_kit\"><option value=\"\">ユニフォームを選択してください</option></select>';

  $(document).on('change', '#label_league', function() {
    var leagueVal = $('#label_league').val();
    if (leagueVal !== "") {
      var selectedTemplateOfTeam = $("#teams-of-league_" + leagueVal);
      $('#label_team').remove();
      $('#label_league').after(selectedTemplateOfTeam.html());
      $('#label_kit').remove();
      $('#label_team').after(defaultKitSelect );
      if (teamVal !== "") {
        var selectedTemplateOfKit = $("#kits-of-team_" + teamVal);
        $('#label_kit').remove();
        $('#label_team').after(selectedTemplateOfKit.html());
      }
    }else {
     $('#label_team').remove();
     $('#label_league').after(defaultTeamSelect);
     $('#label_kit').remove();
     $('#label_team').after(defaultKitSelect);
    };
  });

  var teamVal = $('#label_team').val();
  if (teamVal !== "") {
    var selectedTemplateOfKit = $("#kits-of-team_" + teamVal);
    $('#label_kit').remove();
    $('#label_team').after(selectedTemplateOfKit.html());
  };

  $(document).on('change', '#label_team', function() {
    var teamVal = $('#label_team').val();
    if (teamVal !== ""){
      var selectedTemplateOfKit = $("#kits-of-team_" + teamVal);
      $('#label_kit').remove();
      $('#label_team').after(selectedTemplateOfKit.html());
    } else {
      $('#label_kit').remove();
      $('#label_team').after(defaultKitSelect);
    };
  });
});
