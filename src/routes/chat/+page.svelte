<script>
    import Page from "#lib/Page.svelte";
    import {recipientId} from "#lib/store.ts";


</script>

<Page>
    <span>Chatting with {$recipientId}</span>
</Page>